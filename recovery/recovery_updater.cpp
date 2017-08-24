/******************************************************************************
 *
 * recovery_x86vbox.cpp - Extend recovery for x86vbox
 *
 * Copyright (c) 2017 Roger Ye.  All rights reserved.
 * Software License Agreement
 *
 *
 * THIS SOFTWARE IS PROVIDED "AS IS" AND WITH ALL FAULTS.
 * NO WARRANTIES, WHETHER EXPRESS, IMPLIED OR STATUTORY, INCLUDING, BUT
 * NOT LIMITED TO, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE. The AUTHOR SHALL NOT, UNDER
 * ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR CONSEQUENTIAL
 * DAMAGES, FOR ANY REASON WHATSOEVER.
 *
 *****************************************************************************/

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

#include "edify/expr.h"
#include "minzip/Zip.h"
#include "minzip/SysUtil.h"

extern struct selabel_handle *sehandle;

Value* ReprogramX86vboxFn(const char* name, State* state, int argc, Expr* argv[]) {
  bool success = false;

  if (argc != 2) {
    return ErrorAbort(state, kArgsParsingFailure, "%s() expects 2 args, got %d", name, argc);
  }

  char* zip_path;
  char* dest_path;
  if (ReadArgs(state, argv, 2, &zip_path, &dest_path) < 0) return NULL;

  struct utimbuf timestamp = { 1217592000, 1217592000 };  // 8/1/2008 default

  /* Start to extract files. */
  MemMapping map;
  if (sysMapFile(zip_path, &map) != 0) {
      printf("failed to map package %s\n", zip_path);
      sysReleaseMap(&map);
      unlink(zip_path);
      free(zip_path);
      free(dest_path);
      return NULL;
  }

  ZipArchive za;
  int err;
  err = mzOpenZipArchive(map.addr, map.length, &za);
  if (err != 0) {
      printf("failed to open package %s: %s\n",
    		  zip_path, strerror(err));
      mzCloseZipArchive(&za);
      sysReleaseMap(&map);
      unlink(zip_path);
      free(zip_path);
      free(dest_path);
      return NULL;
  }

  success = mzExtractRecursive(&za, "android-x86vbox", dest_path,
                                    &timestamp,
                                    NULL, NULL, sehandle);
  /* End to extract files. */
  mzCloseZipArchive(&za);
  sysReleaseMap(&map);
  unlink(zip_path);
  free(zip_path);
  free(dest_path);

  return StringValue(strdup(success ? "t" : ""));
}

void Register_librecovery_updater_x86vbox() {
  RegisterFunction("x86vbox.reprogram", ReprogramX86vboxFn);
}

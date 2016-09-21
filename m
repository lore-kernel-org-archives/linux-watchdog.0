Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from resqmta-po-05v.sys.comcast.net ([96.114.154.164]:46064 "EHLO
        resqmta-po-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S941117AbcIUTrk (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 21 Sep 2016 15:47:40 -0400
From: Shuah Khan <shuahkh@osg.samsung.com>
To: corbet@lwn.net, tomas.winkler@intel.com, tglx@linutronix.de,
        clemens@ladisch.de, wim@iguana.be, linux@roeck-us.net,
        davem@davemloft.net, geert@linux-m68k.org,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        kvalo@codeaurora.org, mchehab@kernel.org, ghackmann@google.com,
        ben@decadent.org.uk, maheshkhanwalkar@gmail.com
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v2 0/4] Move runnable examples code from Documentation to samples
Date: Wed, 21 Sep 2016 13:47:29 -0600
Message-Id: <cover.1474485474.git.shuahkh@osg.samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Move runnable examples code from Documentation to samples. I moved
just the example code, and left documentation files as is.

I dropped accounting, laptops, and pcmcia from this v2 series as per
the v1 feedback on these being a better fit under tools. I will send
a separate v2 for them.

If v2 patches look good, and if I get an okay, I will try to get these
into 4.9-rc1

Changes since v1:
- Updated location information in .txt for timers, watchdog, and
  auxdisplay
- Updated MAINTAINERS file for misc-devices/mei based on feedback
  from Tomas Winkler
- Added Acked-by from Jon Corbet for timers, and misc-devices/mei

Shuah Khan (4):
  samples: move misc-devices/mei example code from Documentation
  samples: move timers example code from Documentation
  samples: move watchdog example code from Documentation
  samples: move auxdisplay example code from Documentation

 Documentation/Makefile                           |   4 +-
 Documentation/auxdisplay/.gitignore              |   1 -
 Documentation/auxdisplay/Makefile                |   7 -
 Documentation/auxdisplay/cfag12864b              |   2 +-
 Documentation/auxdisplay/cfag12864b-example.c    | 281 -------------
 Documentation/misc-devices/Makefile              |   1 -
 Documentation/misc-devices/mei/.gitignore        |   1 -
 Documentation/misc-devices/mei/Makefile          |   5 -
 Documentation/misc-devices/mei/TODO              |   2 -
 Documentation/misc-devices/mei/mei-amt-version.c | 479 -----------------------
 Documentation/timers/.gitignore                  |   1 -
 Documentation/timers/Makefile                    |   5 -
 Documentation/timers/hpet.txt                    |   2 +-
 Documentation/timers/hpet_example.c              | 294 --------------
 Documentation/watchdog/Makefile                  |   1 -
 Documentation/watchdog/src/.gitignore            |   1 -
 Documentation/watchdog/src/Makefile              |   5 -
 Documentation/watchdog/src/watchdog-simple.c     |  24 --
 Documentation/watchdog/watchdog-api.txt          |   2 +-
 Documentation/watchdog/wdt.txt                   |   2 +-
 MAINTAINERS                                      |   1 +
 samples/auxdisplay/.gitignore                    |   1 +
 samples/auxdisplay/Makefile                      |   9 +
 samples/auxdisplay/cfag12864b-example.c          | 281 +++++++++++++
 samples/mei/.gitignore                           |   1 +
 samples/mei/Makefile                             |   9 +
 samples/mei/TODO                                 |   2 +
 samples/mei/mei-amt-version.c                    | 479 +++++++++++++++++++++++
 samples/timers/.gitignore                        |   1 +
 samples/timers/Makefile                          |  15 +
 samples/timers/hpet_example.c                    | 294 ++++++++++++++
 samples/watchdog/.gitignore                      |   1 +
 samples/watchdog/Makefile                        |   8 +
 samples/watchdog/watchdog-simple.c               |  24 ++
 34 files changed, 1132 insertions(+), 1114 deletions(-)
 delete mode 100644 Documentation/auxdisplay/.gitignore
 delete mode 100644 Documentation/auxdisplay/Makefile
 delete mode 100644 Documentation/auxdisplay/cfag12864b-example.c
 delete mode 100644 Documentation/misc-devices/Makefile
 delete mode 100644 Documentation/misc-devices/mei/.gitignore
 delete mode 100644 Documentation/misc-devices/mei/Makefile
 delete mode 100644 Documentation/misc-devices/mei/TODO
 delete mode 100644 Documentation/misc-devices/mei/mei-amt-version.c
 delete mode 100644 Documentation/timers/.gitignore
 delete mode 100644 Documentation/timers/Makefile
 delete mode 100644 Documentation/timers/hpet_example.c
 delete mode 100644 Documentation/watchdog/Makefile
 delete mode 100644 Documentation/watchdog/src/.gitignore
 delete mode 100644 Documentation/watchdog/src/Makefile
 delete mode 100644 Documentation/watchdog/src/watchdog-simple.c
 create mode 100644 samples/auxdisplay/.gitignore
 create mode 100644 samples/auxdisplay/Makefile
 create mode 100644 samples/auxdisplay/cfag12864b-example.c
 create mode 100644 samples/mei/.gitignore
 create mode 100644 samples/mei/Makefile
 create mode 100644 samples/mei/TODO
 create mode 100644 samples/mei/mei-amt-version.c
 create mode 100644 samples/timers/.gitignore
 create mode 100644 samples/timers/Makefile
 create mode 100644 samples/timers/hpet_example.c
 create mode 100644 samples/watchdog/.gitignore
 create mode 100644 samples/watchdog/Makefile
 create mode 100644 samples/watchdog/watchdog-simple.c

-- 
2.7.4


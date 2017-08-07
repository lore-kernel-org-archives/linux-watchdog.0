Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.ispras.ru ([83.149.199.45]:51196 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751399AbdHGNWT (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 7 Aug 2017 09:22:19 -0400
From: Anton Volkov <avolkov@ispras.ru>
Subject: Possible race in pc87413_wdt.ko
To: wim@iguana.be
Cc: linux@roeck-us.net, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Message-ID: <da42be1b-f442-6294-a163-84e1b971a651@ispras.ru>
Date: Mon, 7 Aug 2017 16:22:17 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello.

While searching for races in the Linux kernel I've come across 
"drivers/watchdog/pc87413_wdt.ko" module. Here is a question that I came 
up with while analyzing results. Lines are given using the info from 
Linux v4.12.

Consider the following case:

Thread 1:                          Thread 2:
pc87413_init
    misc_register(&pc87413_miscdev)
-> pc87413_get_swc_base_addr       pc87413_open
                                    -> pc87413_refresh
                                       -> pc87413_swc_bank3
      swc_base_addr = ...                  <read access to swc_base_addr>
      (pc87413_wdt.c: line 133)            (pc87413_wdt.c: line 146)

So in this case preemptive registration of the device leads to a 
possibility of race between the initialization process and a callback to 
the registered device.

Is this race feasible from your point of view? And if it is, is it 
possible to move the device registration a bit further down in the 
pc87413_init function?

Thank you for your time.

-- Anton Volkov
Linux Verification Center, ISPRAS
web: http://linuxtesting.org
e-mail: avolkov@ispras.ru

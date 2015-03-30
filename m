Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:37040 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241AbbC3MPk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 30 Mar 2015 08:15:40 -0400
Received: by wiaa2 with SMTP id a2so126753431wia.0
        for <linux-watchdog@vger.kernel.org>; Mon, 30 Mar 2015 05:15:39 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 30 Mar 2015 08:15:38 -0400
Message-ID: <CALah4NdwMPmu=iu=JaRyCYZQCb7nsJ_AWcXiT83v-wMNAA6hxQ@mail.gmail.com>
Subject: NMI watchdog
From: Justin Keller <justincompsci@gmail.com>
To: linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello,
Although not running a vanilla kernel on this machine, I have reported the
issue to the distribution's bug tracking system. It has been almost a week
with no response, so I am sending this email.

Multiple times, when I return to my computer from being away for a little
while, I noticed:
Message from syslogd@redacted at Mar 23 XX:XX:XX ...
kernel:[1059322.470817] NMI watchdog: BUG: soft lockup - CPU#1 stuck for
22s! [kswapd0:31]

Dmesg | grep NMI produced:
[1151200.727734] sending NMI to all CPUs:
[1151200.727812] NMI backtrace for cpu 0
[1151200.764129] INFO: NMI handler (arch_trigger_all_cpu_backtrace_handler)
took too long to run: 36.262 msecs
[1151200.764198] NMI backtrace for cpu 1
[1151216.700893] sending NMI to all CPUs:
[1151216.700984] NMI backtrace for cpu 1
[1151216.706524] NMI backtrace for cpu 0
[1723994.455161] <NMI> [<ffffffff81554a5e>] ? dump_stack+0x41/0x51

I didn't have time to grep for kswapd or to investigate further. Long story
short, the machine was shutdown shortly afterwords.

Justin

Return-Path: <SRS0=mhZ9=QV=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599C3C10F04
	for <linux-watchdog@archiver.kernel.org>; Thu, 14 Feb 2019 09:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C55222A1
	for <linux-watchdog@archiver.kernel.org>; Thu, 14 Feb 2019 09:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388802AbfBNJ1d convert rfc822-to-8bit (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:27:33 -0500
Received: from mga11.intel.com ([192.55.52.93]:40587 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388196AbfBNJ1d (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 14 Feb 2019 04:27:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 01:27:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,368,1544515200"; 
   d="scan'208";a="116132673"
Received: from irsmsx109.ger.corp.intel.com ([163.33.3.23])
  by orsmga006.jf.intel.com with ESMTP; 14 Feb 2019 01:27:30 -0800
Received: from irsmsx108.ger.corp.intel.com ([169.254.11.28]) by
 IRSMSX109.ger.corp.intel.com ([169.254.13.83]) with mapi id 14.03.0415.000;
 Thu, 14 Feb 2019 09:27:18 +0000
From:   "Mehrtens, Hauke" <hauke.mehrtens@intel.com>
To:     "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: print active stack on watchdog pre timeout for separate irq stack
Thread-Topic: print active stack on watchdog pre timeout for separate irq
 stack
Thread-Index: AdTERhkHQ/tMdayNR9+t+VaCObWnBg==
Date:   Thu, 14 Feb 2019 09:27:17 +0000
Message-ID: <9231D502B07C5E4A8B32D5115C9F19991F89C484@IRSMSX108.ger.corp.intel.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzcwYWNjMzMtOWM2OS00YTRmLWFjZTItY2Y3ZTZmZTcxZjE5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidFM1SGwxR3NhR3oyNkdoak9jeVc3U0FVOUFnUTZJclptMGgrOWZLSmRIZVNpTnNzVmNsdUIzTDUwNjlQNTdVRiJ9
x-ctpclassification: CTP_NT
x-originating-ip: [163.33.239.180]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Hi,

We would like to print the stack of the currently active kernel thread from the interrupt handler when the watchdog pre timeout interrupt for our watchdog is triggered, currently we have a WARN_ONCE() in the code of the interrupt handler, but this only prints the interrupt stack, which is pretty boring. On MIPS the interrupts are handled on a separate stack and not on top of the stack of the current active kernel thread to avoid stack overflows. Is there some function which would print the stack trace of the current active kernel thread in addition or instead of the interrupt stack inside of an interrupt?

The kernel also has these pre timeout handlers, but they also seem to be affected by this problem:
https://elixir.bootlin.com/linux/v5.0-rc6/source/drivers/watchdog/pretimeout_panic.c

This was seen on kernel 4.9.109, but I am not aware of any changes in this area in the last few years. 

Hauke

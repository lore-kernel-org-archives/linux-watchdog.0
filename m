Return-Path: <SRS0=5d9e=VS=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF47C76191
	for <linux-watchdog@archiver.kernel.org>; Sun, 21 Jul 2019 20:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6470C208E4
	for <linux-watchdog@archiver.kernel.org>; Sun, 21 Jul 2019 20:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=valentin-vidic.from.hr header.i=@valentin-vidic.from.hr header.b="kl7rOIcM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfGUUji (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 21 Jul 2019 16:39:38 -0400
Received: from valentin-vidic.from.hr ([94.229.67.141]:42359 "EHLO
        valentin-vidic.from.hr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfGUUjh (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 21 Jul 2019 16:39:37 -0400
X-Greylist: delayed 523 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jul 2019 16:39:37 EDT
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id C449C3A33C; Sun, 21 Jul 2019 22:30:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=valentin-vidic.from.hr; s=2017; t=1563741047;
        bh=dRkkvFqCYh7ciEZia5/KMIUdDE/Ih8fH8hfXRP/lNYg=;
        h=Date:From:To:Subject:From;
        b=kl7rOIcMJPmEJTvpkrtMKgU0EiDO2AXlc/lI0gv67tk9c9xCRX3k4UQRUypjYofll
         1zxFGtYsrs+sYtvUpo7+XsuwIBs71KwPy6y/b+YSXZf/aKkSYqPrz8XD4vV85zQeCI
         Q4IPCQBEkFepKJibYUCJU3S5TRAEjJCLy1QPzh+tGW5V7+t8yjzfDnZZ/vcj7kAqTn
         XePa0jzlUjjPJ7EUVSVuI+tvqgEkH1+AFU6yGJjZVRv+Mdv9G3shmNADfeNOX0w5g4
         rSN+3elIPE5iCdv1psJHJsDBTNr/HAYidJ2eaoyXfjj/t1fw266tWCewo+XKECXAWR
         2ZJ28ZtQrh3ag==
Date:   Sun, 21 Jul 2019 22:30:47 +0200
From:   Valentin =?utf-8?B?VmlkacSH?= <vvidic@valentin-vidic.from.hr>
To:     linux-watchdog@vger.kernel.org
Subject: iTCO_wdt on Intel NUC
Message-ID: <20190721203047.3jd6slko6guz52fl@valentin-vidic.from.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Hello,

I'm having trouble getting iTCO_wdt to work on NUC8i5BEH with kernel 4.19.37-5+deb10u1:

[    9.346099] iTCO_vendor_support: vendor-support=0
[    9.377211] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    9.377397] iTCO_wdt iTCO_wdt: can't request region for resource [mem 0x00c5fffc-0x00c5ffff]
[    9.377407] iTCO_wdt: probe of iTCO_wdt failed with error -16

Is there a way to check if the TCO hardware is missing in this machine
or something else needs to be updated to get it working?

Valentin

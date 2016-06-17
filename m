Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from vpn.innerrange.com.au ([203.122.143.146]:31424 "EHLO
	remote.innerrange.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754899AbcFQCLz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 16 Jun 2016 22:11:55 -0400
From: Craig McQueen <craig.mcqueen@innerrange.com>
To: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Date: Fri, 17 Jun 2016 12:06:26 +1000
Subject: ALi M6117 watchdog driver
Message-ID: <5500469A22567C4BAF673A6E86AFA3A4022D2A096F97@IR-CENTRAL.corp.innerrange.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

I am using a DM&P eBox mini-PC eBox-3310A, which uses the Ali M6117 watchdog.

I found an old driver for that, and I've updated it for more recent Linux kernels, and using the Linux watchdog kernel API.

Out-of-tree code is here:
https://github.com/cmcqueen/alim6117_wdt

Can this be integrated into the kernel tree?

Regards,
Craig McQueen


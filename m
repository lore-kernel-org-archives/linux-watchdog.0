Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from fallback8.mail.ru ([94.100.176.136]:60253 "EHLO
	fallback8.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964Ab2KYNhu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 25 Nov 2012 08:37:50 -0500
Received: from smtp44.i.mail.ru (smtp44.i.mail.ru [94.100.177.104])
	by fallback8.mail.ru (mPOP.Fallback_MX) with ESMTP id 8DF8DDF6043
	for <linux-watchdog@vger.kernel.org>; Sun, 25 Nov 2012 17:25:12 +0400 (MSK)
Date: Sun, 25 Nov 2012 17:24:47 +0400
From: Alexander Shiyan <shc_work@mail.ru>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>
Subject: INTEL_SCU_WATCHDOG is orphaned
Message-Id: <20121125172447.6baf4115522107d5396bc780@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello.

Kernel symbol X86_MRST has been removed from the kernel.
INTEL_SCU_WATCHDOG driver can never be compiled due dependence of X86_MRST
which remained in the drivers/watchdog/Kconfig.
Unfortunately, I do not know the right decision on this issue and just want
to draw the attention of developers to it.
Thanks!

-- 
Alexander Shiyan <shc_work@mail.ru>

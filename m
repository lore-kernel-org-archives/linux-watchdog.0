Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.elliptictech.com ([209.217.122.41]:40485 "EHLO
	mail.ellipticsemi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939Ab1GOP2S (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 15 Jul 2011 11:28:18 -0400
From: Nick Bowler <nbowler@elliptictech.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 0/3] SP805 updates for Versatile Express
Date: Fri, 15 Jul 2011 11:03:59 -0400
Message-Id: <1310742242-14647-1-git-send-email-nbowler@elliptictech.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Here are some updates to get the SP805 watchdog working on the ARM
Versatile Express.  The first two patches fix observed issues; the
third fixes a potential (but not observed) issue with asynchronous
posted writes.

All three patches are independent and should be applicable in any
order, with some fuzz on the third.


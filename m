Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:63910 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933063Ab3CEEy3 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 4 Mar 2013 23:54:29 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 0/8] watchdog: w83627hf: Convert to watchdog infrastructure
Date: Mon,  4 Mar 2013 20:54:11 -0800
Message-Id: <1362459259-9733-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Convert to watchdog infrastructure, cleanup, add support for additional
chips, and merge with W83697HF and W83697UG watchdog drivers.

Tested with NCT6775 and NCT6776. I'll be able to test the code with W83627UHG.
Additional test feedback, especially for other chips, would be appreciated.

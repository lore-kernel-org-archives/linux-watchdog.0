Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38915 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752541AbbK3RAV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 30 Nov 2015 12:00:21 -0500
To: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"wim@iguana.be" <wim@iguana.be>
From: Guenter Roeck <linux@roeck-us.net>
Subject: Need for ref/unref functions in watchdog drivers
Message-ID: <565C80A2.6020505@roeck-us.net>
Date: Mon, 30 Nov 2015 09:00:18 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

I keep being puzzled about the ref/unref functions for watchdog drivers.

Hardly any driver implements those functions, even though many allocate
the watchdog_device data structure dynamically. At the same time, I don't
recall ever seeing a crash or traceback because of it.

Granted, many watchdogs are only loaded and never unloaded, but one
should think that the problem is seen at least once in a while.

Does anyone know how to trigger the problem which makes the ref/unref
functions necessary ? I would like to reproduce it and then try to find a better
solution, ie one that doesn't need those functions in the drivers (seems to me
the infrastructure should ensure that a driver isn't unloaded while in use).

Thanks,
Guenter


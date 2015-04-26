Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34865 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbbDZPc2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 26 Apr 2015 11:32:28 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.85)
	(envelope-from <linux@roeck-us.net>)
	id 1YmOXj-000biA-JM
	for linux-watchdog@vger.kernel.org; Sun, 26 Apr 2015 15:32:27 +0000
Message-ID: <553D0503.7050207@roeck-us.net>
Date: Sun, 26 Apr 2015 08:32:19 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Timo Kokkonen <timo.kokkonen@offcode.fi>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, boris.brezillon@free-electrons.com,
	nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com
CC: Wenyou.Yang@atmel.com
Subject: Re: [PATCHv7 7/8] watchdog: omap_wdt: Fix memory leak on probe fail
References: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi> <1429701102-22320-8-git-send-email-timo.kokkonen@offcode.fi>
In-Reply-To: <1429701102-22320-8-git-send-email-timo.kokkonen@offcode.fi>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/22/2015 04:11 AM, Timo Kokkonen wrote:
> Structures allocated on the beginning of the probe function must be
> freed in case of failure.

Really ? The functions are allocated with devm_kzalloc.
It might be useful to introduce an error on purpose, have the code
jump to your new label, and observe what happens.

Guenter


Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:55464 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754382AbbG3BC6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 29 Jul 2015 21:02:58 -0400
Message-ID: <55B977BF.60000@roeck-us.net>
Date: Wed, 29 Jul 2015 18:02:55 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>
CC: Boris Brezillon <boris.brezillon@free-electrons.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 02/20] Documentation: watchdog: at91sam9_wdt: add clocks
 property
References: <1438215726-27452-1-git-send-email-alexandre.belloni@free-electrons.com> <1438215726-27452-3-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1438215726-27452-3-git-send-email-alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/29/2015 05:21 PM, Alexandre Belloni wrote:
> The watchdog has an input clock, the slow clock. It is required as it will
> not function without it.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


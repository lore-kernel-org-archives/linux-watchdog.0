Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:50090 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202AbbG3Okr (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 30 Jul 2015 10:40:47 -0400
Message-ID: <55BA376D.7060305@roeck-us.net>
Date: Thu, 30 Jul 2015 07:40:45 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@pengutronix.de>, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
CC: kernel@pengutronix.de
Subject: Re: [PATCH] watchdog: gpio-wdt: be more strict about hw_algo matching
References: <1438248743-8722-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1438248743-8722-1-git-send-email-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 07/30/2015 02:32 AM, Uwe Kleine-König wrote:
> strncmp(algo, "toggle", 6) doesn't compare the trailing '\0' byte, so
> using
>
> 	hw_algo = "toggleboggle"
>
> is recognized the same way as
>
> 	hw_algo = "toggle"
>
> . While this doesn't introduce any problems for a device tree that
> sticks to the documented settings it's still ugly.
>
> Fix this by using strcmp to only match on "toggle" and "level".
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


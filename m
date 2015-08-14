Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45125 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbbHNTFk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 14 Aug 2015 15:05:40 -0400
Date: Fri, 14 Aug 2015 21:05:35 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 4/8] watchdog: Make set_timeout function optional
Message-ID: <20150814190535.GV9999@pengutronix.de>
References: <1439010167-13818-1-git-send-email-linux@roeck-us.net>
 <1439010167-13818-5-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1439010167-13818-5-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello Guenter,

On Fri, Aug 07, 2015 at 10:02:43PM -0700, Guenter Roeck wrote:
> For some watchdogs, the hardware timeout is fixed, and the
> watchdog driver depends on the watchdog core to handle the
> actual timeout. In this situation, the watchdog driver might
> only set the 'timeout' variable but do nothing else.
> This can as well be handled by the infrastructure, so make
> the set_timeout callback optional. If WDIOF_SETTIMEOUT is
> configured but the .set_timeout callback is not available,
> update the timeout variable in the infrastructure code.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

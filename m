Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:55918 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753719Ab3KCSGu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 3 Nov 2013 13:06:50 -0500
Message-ID: <527690B9.7010202@roeck-us.net>
Date: Sun, 03 Nov 2013 10:06:49 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Boris BREZILLON <b.brezillon@overkiz.com>,
	Wim Van Sebroeck <wim@iguana.be>
CC: Fabio Porcedda <fabio.porcedda@gmail.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Guenter Roeck <groeck7@gmail.com>,
	Yang Wenyou <wenyou.yang@atmel.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 1/3] watchdog: at91sam9_wdt: fix secs_to_ticks
References: <1383501164-8111-1-git-send-email-b.brezillon@overkiz.com> <1383501164-8111-2-git-send-email-b.brezillon@overkiz.com>
In-Reply-To: <1383501164-8111-2-git-send-email-b.brezillon@overkiz.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/03/2013 09:52 AM, Boris BREZILLON wrote:
> Fix the secs_to_ticks macro in case 0 is passed as an argument.
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


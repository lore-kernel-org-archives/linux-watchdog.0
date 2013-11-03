Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:60026 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956Ab3KCSct (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 3 Nov 2013 13:32:49 -0500
Message-ID: <527696D0.9080705@roeck-us.net>
Date: Sun, 03 Nov 2013 10:32:48 -0800
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
Subject: Re: [PATCH 3/3] watchdog: at91sam9_wdt: increase security margin
 on watchdog counter reset
References: <1383501164-8111-1-git-send-email-b.brezillon@overkiz.com> <1383501164-8111-4-git-send-email-b.brezillon@overkiz.com>
In-Reply-To: <1383501164-8111-4-git-send-email-b.brezillon@overkiz.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/03/2013 09:52 AM, Boris BREZILLON wrote:
> Try to reset the watchdog counter 4 or 2 times more often than actually
> requested, to avoid spurious watchdog reset.
> If this is not possible because of the min_heartbeat value, reset it at
> the min_heartbeat period.
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>



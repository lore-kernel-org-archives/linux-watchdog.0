Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:59444 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbaB1DVN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 27 Feb 2014 22:21:13 -0500
Message-ID: <531000A4.8060509@roeck-us.net>
Date: Thu, 27 Feb 2014 19:21:08 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Jingoo Han <jg1.han@samsung.com>,
	'Wim Van Sebroeck' <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org,
	'Jonathan McDowell' <noodles@earth.li>
Subject: Re: [PATCH 2/6] watchdog: pc87413: split module author names
References: <004301cf337e$97e7a3f0$c7b6ebd0$%han@samsung.com> <004601cf337e$dcd7f4b0$9687de10$%han@samsung.com>
In-Reply-To: <004601cf337e$dcd7f4b0$9687de10$%han@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/26/2014 09:43 PM, Jingoo Han wrote:
> Split module author names and remove unnecessary braces, in order
> to fix the following checkpatch issues.
>
>    WARNING: quoted string split across lines
>    WARNING: braces {} are not necessary for single statement blocks
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>



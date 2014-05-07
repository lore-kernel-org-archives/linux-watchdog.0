Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:61681 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932297AbaEGMZc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 7 May 2014 08:25:32 -0400
Message-ID: <536A2636.1020005@roeck-us.net>
Date: Wed, 07 May 2014 05:25:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Jingoo Han <jg1.han@samsung.com>,
	'Wim Van Sebroeck' <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org,
	'Michal Simek' <michal.simek@xilinx.com>
Subject: Re: [PATCH] watchdog: xilinx: Make of_device_id array const
References: <021701cf69d0$43674870$ca35d950$%han@samsung.com>
In-Reply-To: <021701cf69d0$43674870$ca35d950$%han@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/07/2014 01:42 AM, Jingoo Han wrote:
> Make of_device_id array const, because all OF functions
> handle it as const.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---

Reviewed-by: Guenter Roeck <linux@roeck-us.net>



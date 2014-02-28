Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:59009 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbaB1DVp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 27 Feb 2014 22:21:45 -0500
Message-ID: <531000C5.9040009@roeck-us.net>
Date: Thu, 27 Feb 2014 19:21:41 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Jingoo Han <jg1.han@samsung.com>,
	'Wim Van Sebroeck' <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org,
	'Akinobu Mita' <akinobu.mita@gmail.com>
Subject: Re: [PATCH 4/6] watchdog: ibmasr: fix incorrect placement of __initdata
 marker
References: <004301cf337e$97e7a3f0$c7b6ebd0$%han@samsung.com> <004801cf337f$41d5af60$c5810e20$%han@samsung.com>
In-Reply-To: <004801cf337f$41d5af60$c5810e20$%han@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/26/2014 09:46 PM, Jingoo Han wrote:
> The __initdata marker can be virtually anywhere on the line,
> EXCEPT right after "struct". The preferred location is before
> the "=" sign if there is one, or before the trailing ";"
> otherwise. It also fixes the following chechpatch warning.
>
>    WARNING: __initdata should be placed after ibmasr_id_table[]
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>



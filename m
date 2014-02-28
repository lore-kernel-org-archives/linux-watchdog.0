Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:55433 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbaB1DWQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 27 Feb 2014 22:22:16 -0500
Message-ID: <531000E3.9090104@roeck-us.net>
Date: Thu, 27 Feb 2014 19:22:11 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Jingoo Han <jg1.han@samsung.com>,
	'Wim Van Sebroeck' <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org, 'Kim Milo' <Milo.Kim@ti.com>
Subject: Re: [PATCH 6/6] watchdog: softdog: remove unnecessary initialization
 of static variable
References: <004301cf337e$97e7a3f0$c7b6ebd0$%han@samsung.com> <004a01cf337f$9c6b3ad0$d541b070$%han@samsung.com>
In-Reply-To: <004a01cf337f$9c6b3ad0$d541b070$%han@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/26/2014 09:48 PM, Jingoo Han wrote:
> Remove unnecessary initialization of static variable in order to
> fix the following checkpatch issue.
>
>    ERROR: do not initialise statics to 0 or NULL
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>



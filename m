Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:60904 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750961AbcIIE14 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 9 Sep 2016 00:27:56 -0400
Subject: Re: [PATCH] watchdog: iTCO_wdt: constify iTCO_wdt_pm structure
To: Julia Lawall <Julia.Lawall@lip6.fr>,
        Wim Van Sebroeck <wim@iguana.be>
References: <1472415986-16035-1-git-send-email-Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <a2174cc6-8266-26b5-99e0-aef0c5e5d18c@roeck-us.net>
Date: Thu, 8 Sep 2016 21:27:53 -0700
MIME-Version: 1.0
In-Reply-To: <1472415986-16035-1-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 08/28/2016 01:26 PM, Julia Lawall wrote:
> iTCO_wdt_pm, of type struct dev_pm_ops, is never modified, so declare it as
> const.
>
> Done with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


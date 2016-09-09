Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34047 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752075AbcIIE3P (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 9 Sep 2016 00:29:15 -0400
Subject: Re: [PATCH 2/2] watchdog: constify watchdog_ops structures
To: Julia Lawall <Julia.Lawall@lip6.fr>,
        Wim Van Sebroeck <wim@iguana.be>
References: <1472751326-22897-1-git-send-email-Julia.Lawall@lip6.fr>
 <1472751326-22897-3-git-send-email-Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <d0b260e7-1f71-35e3-3b8c-2c71495431bf@roeck-us.net>
Date: Thu, 8 Sep 2016 21:29:13 -0700
MIME-Version: 1.0
In-Reply-To: <1472751326-22897-3-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/01/2016 10:35 AM, Julia Lawall wrote:
> Check for watchdog_ops structures that are only stored in the ops field of
> a watchdog_device structure.  This field is declared const, so watchdog_ops
> structures that have this property can be declared as const also.
>
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
>
> // <smpl>
> @r disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct watchdog_ops i@p = { ... };
>
> @ok@
> identifier r.i;
> struct watchdog_device e;
> position p;
> @@
> e.ops = &i@p;
>
> @bad@
> position p != {r.p,ok.p};
> identifier r.i;
> struct watchdog_ops e;
> @@
> e@i@p
>
> @depends on !bad disable optional_qualifier@
> identifier r.i;
> @@
> static
> +const
>  struct watchdog_ops i = { ... };
> // </smpl>
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>


Reviewed-by: Guenter Roeck <linux@roeck-us.net>



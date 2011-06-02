Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64229 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035Ab1FBNEn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 2 Jun 2011 09:04:43 -0400
Received: by gyd10 with SMTP id 10so314783gyd.19
        for <linux-watchdog@vger.kernel.org>; Thu, 02 Jun 2011 06:04:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201106021454.17652.florian@openwrt.org>
References: <201106021454.17652.florian@openwrt.org>
Date: Thu, 2 Jun 2011 15:04:42 +0200
Message-ID: <BANLkTi=e=ZVdY7ki8AjM8Wg47iyfCNAu5A@mail.gmail.com>
Subject: Re: [PATCH 1/3] WATCHDOG: mtx1-wdt: use dev_{err,info} instead of printk()
From: Manuel Lauss <manuel.lauss@googlemail.com>
To: Florian Fainelli <florian@openwrt.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Florian,

On Thu, Jun 2, 2011 at 2:54 PM, Florian Fainelli <florian@openwrt.org> wrote:
>
> Signed-off-by: Florian Fainelli <florian@openwrt.org>
> ---
> diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c

While you're at it, please change line 246 from

static struct platform_driver mtx1_wdt = {
to
static struct platform_driver mtx1_wdt_driver = {

to get rid of a really annoying section mismatch warning.

Thanks!
      Manuel Lauss

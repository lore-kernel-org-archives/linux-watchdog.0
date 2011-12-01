Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36134 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752658Ab1LAQLq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 1 Dec 2011 11:11:46 -0500
Received: by iage36 with SMTP id e36so2686314iag.19
        for <linux-watchdog@vger.kernel.org>; Thu, 01 Dec 2011 08:11:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1317631978-22818-1-git-send-email-linus.walleij@stericsson.com>
References: <1317631978-22818-1-git-send-email-linus.walleij@stericsson.com>
Date: Thu, 1 Dec 2011 17:11:45 +0100
Message-ID: <CACRpkdb9+ZsnXFbjJXg-=amnVwYu_EyKftYxRptjq8SDoqurvA@mail.gmail.com>
Subject: Re: [PATCH] [WATCHDOG] move coh901327 state holders
From: Linus Walleij <linus.walleij@linaro.org>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Oct 3, 2011 at 10:52 AM, Linus Walleij
<linus.walleij@stericsson.com> wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
>
> The state holders used in the PM path of the drivers report as
> unused variables when compiling without CONFIG_PM so let's
> move them inside CONFIG_PM.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Ping on this, Wim is this patch OK?

Yours,
Linus Walleij

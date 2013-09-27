Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:53293 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639Ab3I0QrG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 27 Sep 2013 12:47:06 -0400
Received: by mail-oa0-f42.google.com with SMTP id g12so2240395oah.29
        for <linux-watchdog@vger.kernel.org>; Fri, 27 Sep 2013 09:47:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1380276986-24131-5-git-send-email-l.krishna@samsung.com>
References: <1380276986-24131-1-git-send-email-l.krishna@samsung.com>
	<1380276986-24131-5-git-send-email-l.krishna@samsung.com>
Date: Fri, 27 Sep 2013 22:17:04 +0530
Message-ID: <CAK9yfHyoLGU-Y9C+a9qB+ew3ixgx3NxJxWykQycnJBGBaXjXjA@mail.gmail.com>
Subject: Re: [PATCH V2 4/4] ARM: dts: exynos: add PMU registers addresses and
 mask bit to watchdog node
From: Sachin Kamat <sachin.kamat@linaro.org>
To: Leela Krishna Amudala <l.krishna@samsung.com>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Kukjin Kim <kgene.kim@samsung.com>, devicetree@vger.kernel.org,
	Tomasz Figa <t.figa@samsung.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Leela,

On 27 September 2013 15:46, Leela Krishna Amudala <l.krishna@samsung.com> wrote:
>         watchdog@101D0000 {
> -               compatible = "samsung,s3c2410-wdt";
> -               reg = <0x101D0000 0x100>;
> +               compatible = "samsung,s3c5250-wdt";
> +               reg = <0x101D0000 0x100>, <0x10040408 0x4>, <0x1004040c 0x4>;

nit: Please maintain consistency with the hex number case.
-- 
With warm regards,
Sachin

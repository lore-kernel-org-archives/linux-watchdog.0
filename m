Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:62060 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753655Ab3I0VHK (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 27 Sep 2013 17:07:10 -0400
Received: by mail-qa0-f42.google.com with SMTP id cm18so840495qab.8
        for <linux-watchdog@vger.kernel.org>; Fri, 27 Sep 2013 14:07:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1380276986-24131-3-git-send-email-l.krishna@samsung.com>
References: <1380276986-24131-1-git-send-email-l.krishna@samsung.com>
	<1380276986-24131-3-git-send-email-l.krishna@samsung.com>
Date: Fri, 27 Sep 2013 14:07:09 -0700
Message-ID: <CAD=FV=WCTw+SnMjGteAYNbbiSu12umZcjQqfCd08srFQL+gy4w@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] ARM: dts: add watchdog device tree node for exynos5420
From: Doug Anderson <dianders@chromium.org>
To: Leela Krishna Amudala <l.krishna@samsung.com>
Cc: linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Kukjin Kim <kgene.kim@samsung.com>, devicetree@vger.kernel.org,
	Tomasz Figa <t.figa@samsung.com>,
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Leela Krishna,

On Fri, Sep 27, 2013 at 3:16 AM, Leela Krishna Amudala
<l.krishna@samsung.com> wrote:
> Add watchdog device tree node for exynos5420
>
> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi |    6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Doug Anderson <dianders@chromium.org>

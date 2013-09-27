Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qe0-f44.google.com ([209.85.128.44]:43958 "EHLO
	mail-qe0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754714Ab3I0VEY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 27 Sep 2013 17:04:24 -0400
Received: by mail-qe0-f44.google.com with SMTP id 3so2252752qeb.17
        for <linux-watchdog@vger.kernel.org>; Fri, 27 Sep 2013 14:04:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1380276986-24131-2-git-send-email-l.krishna@samsung.com>
References: <1380276986-24131-1-git-send-email-l.krishna@samsung.com>
	<1380276986-24131-2-git-send-email-l.krishna@samsung.com>
Date: Fri, 27 Sep 2013 14:04:22 -0700
Message-ID: <CAD=FV=XAJR1ccupP3iD+pCjRafsWnLw0C4wk=svp7g_6yLZt7A@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] ARM: dts: Fix the watchdog DT node name for Exynos5
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
> Fixes the watchdog DT node name for Exynos5 as per the DT node naming
> convention also update "status" property for Exynos5250 SoC.
>
> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5.dtsi    |    2 +-
>  arch/arm/boot/dts/exynos5250.dtsi |    3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Doug Anderson <dianders@chromium.org>

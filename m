Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59921 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087Ab1EMTZM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 13 May 2011 15:25:12 -0400
Received: by wya21 with SMTP id 21so2138619wya.19
        for <linux-watchdog@vger.kernel.org>; Fri, 13 May 2011 12:25:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1304968714-3362-1-git-send-email-manuel.lauss@googlemail.com>
References: <1304968714-3362-1-git-send-email-manuel.lauss@googlemail.com>
Date: Fri, 13 May 2011 21:25:10 +0200
Message-ID: <BANLkTinNsTJ-FmqFH=6+h7Ep8ZEJDOb2tw@mail.gmail.com>
Subject: Re: [PATCH] Watchdog: mtx-1: fix abuse of gpio registers
From: Manuel Lauss <manuel.lauss@googlemail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Cc: Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Mon, May 9, 2011 at 9:18 PM, Manuel Lauss
<manuel.lauss@googlemail.com> wrote:
> This patch replaces the drivers racy abuse of the gpio2 direction
> register with calls to the gpio library.
>
> Cc: Florian Fainelli <florian@openwrt.org>
> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
> ---
> =A0drivers/watchdog/mtx-1_wdt.c | =A0 17 ++++++++++-------
> =A01 files changed, 10 insertions(+), 7 deletions(-)

Please disregard this patch.  It depends on another change to the mtx-1
platform files, and Ralf Baechle already included it in the MIPS tree
(as part of a larger patch to the Alchemy infrastructure) for 2.6.40.

Thanks,
     Manuel Lauss
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

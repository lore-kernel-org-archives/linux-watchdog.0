Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ve0-f177.google.com ([209.85.128.177]:36890 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab3HFHwi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 6 Aug 2013 03:52:38 -0400
Received: by mail-ve0-f177.google.com with SMTP id cz11so58251veb.8
        for <linux-watchdog@vger.kernel.org>; Tue, 06 Aug 2013 00:52:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1375212046-12823-1-git-send-email-carlo.caione@gmail.com>
References: <1375212046-12823-1-git-send-email-carlo.caione@gmail.com>
Date: Tue, 6 Aug 2013 09:52:37 +0200
Message-ID: <CAOQ7t2ajtWXZb5-6vjhk4C=VRy6BA=q3Xd_H8fGmK-JQ8N3-bw@mail.gmail.com>
Subject: Re: [PATCH v7] ARM: sunxi: New watchdog driver for Allwinner A10/A13
From: Carlo Caione <carlo.caione@gmail.com>
To: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	=?ISO-8859-1?Q?Henrik_Nordstr=F6m?= <henrik@henriknordstrom.net>,
	linux@roeck-us.net
Cc: Carlo Caione <carlo.caione@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jul 30, 2013 at 9:20 PM, Carlo Caione <carlo.caione@gmail.com> wrote:
> This patch adds the driver for the watchdog found in the Allwinner A10 and
> A13 SoCs. It has DT-support and uses the new watchdog framework.
>
> Signed-off-by: Carlo Caione <carlo.caione@gmail.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---

Guys, any feedback on this patch?

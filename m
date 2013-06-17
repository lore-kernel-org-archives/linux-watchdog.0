Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:47798 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab3FQVfU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 17 Jun 2013 17:35:20 -0400
Received: by mail-ob0-f170.google.com with SMTP id ef5so3795991obb.15
        for <linux-watchdog@vger.kernel.org>; Mon, 17 Jun 2013 14:35:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1370547265-24854-1-git-send-email-carlo.caione@gmail.com>
References: <1370547265-24854-1-git-send-email-carlo.caione@gmail.com>
Date: Mon, 17 Jun 2013 23:35:18 +0200
Message-ID: <CAOQ7t2ZHQ+tWx5-=dv+eriXk8TVuBn6LGo2wB_f0JKeNtMgdkw@mail.gmail.com>
Subject: Re: [PATCH v5] ARM: sunxi: New watchdog driver for Allwinner A10/A13
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

On Thu, Jun 6, 2013 at 9:34 PM, Carlo Caione <carlo.caione@gmail.com> wrote:
> This patch adds the driver for the watchdog found in the Allwinner A10 and
> A13 SoCs. It has DT-support and uses the new watchdog framework.
>
> Signed-off-by: Carlo Caione <carlo.caione@gmail.com>
> ---
[cut]

Ping

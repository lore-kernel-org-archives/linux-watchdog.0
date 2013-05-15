Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:52190 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756061Ab3EOInJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 15 May 2013 04:43:09 -0400
Message-ID: <51934A94.3070503@free-electrons.com>
Date: Wed, 15 May 2013 10:43:00 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: wim@iguana.be, linux-watchdog@vger.kernel.org
CC: Carlo Caione <carlo.caione@gmail.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: sunxi: New watchdog driver for Allwinner A10/A13
References: <1368390994-27161-1-git-send-email-carlo.caione@gmail.com>
In-Reply-To: <1368390994-27161-1-git-send-email-carlo.caione@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Hi,

Le 12/05/2013 22:36, Carlo Caione a =E9crit :
> This patch adds the driver for the watchdog found in the Allwinner A10 =
and
> A13 SoCs. It has DT-support and uses the new watchdog framework.

I'd like to start some more general discussion here.

All the sunxi boards don't have a PMIC to do the reset properly, so we
chose to do the reboot hook using the watchdog.

How is that handled usually? Obviously, we could have a rather minimal
approach, like this one, where we have code duplication between the arch
code and the watchdog driver code, which is probably not so nice, but I
couldn't find either any convention for this, or a piece of
infrastructure to do so.

What could be the preferred solution?

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:56404 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707AbcBXVWL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 24 Feb 2016 16:22:11 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>, wim@iguana.be,
	manabian@gmail.com, stigge@antcom.de,
	linux-watchdog@vger.kernel.org, linux@roeck-us.net, vz@mleia.com
Subject: Re: [PATCH v3 6/6] arm: lpc32xx: phy3250 remove restart hook
Date: Wed, 24 Feb 2016 22:20:55 +0100
Message-ID: <2913764.6ZXbKHTUYJ@wuerfel>
In-Reply-To: <1456336018-6620-7-git-send-email-slemieux.tyco@gmail.com>
References: <1456336018-6620-1-git-send-email-slemieux.tyco@gmail.com> <1456336018-6620-7-git-send-email-slemieux.tyco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wednesday 24 February 2016 12:46:58 Sylvain Lemieux wrote:
> From: Sylvain Lemieux <slemieux@tycoint.com>
> 
> Remove the restart hook assignment from phy3250;
> this functionality is now managed by
> the pnx4008 watchdog driver.
> 
> Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
> ---
> Note:
> This patch was generated with the option "--unified=2" to ensure
> it can be apply before or after the following git pull request
> for the LPC32xx platform:
> - http://permalink.gmane.org/gmane.linux.ports.arm.kernel/477137
> - http://permalink.gmane.org/gmane.linux.ports.arm.kernel/477138

This patch really needs to come before patch 5 in the series, or
you could combine the two into a single patch.

	Arnd

Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:53413 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbaBGB53 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 6 Feb 2014 20:57:29 -0500
Message-ID: <52F43D88.2050304@roeck-us.net>
Date: Thu, 06 Feb 2014 17:57:28 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Andrew Chew <achew@nvidia.com>, wim@iguana.be, rob@landley.net,
	swarren@wwwdotorg.org, thierry.reding@gmail.com,
	grant.likely@linaro.org, robh+dt@kernel.org, abrestic@chromium.org,
	dgreid@chromium.org, katierh@chromium.org
CC: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 1/1] watchdog: Add tegra watchdog
References: <1391738086-29142-1-git-send-email-achew@nvidia.com>
In-Reply-To: <1391738086-29142-1-git-send-email-achew@nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/06/2014 05:54 PM, Andrew Chew wrote:
> Add a driver for the hardware watchdogs in NVIDIA Tegra SoCs (Tegra30 and
> later).  This driver will configure one watchdog timer that will reset the
> system in the case of a watchdog timeout.
>
> This driver binds to the nvidia,tegra30-timer device node and gets its
> register base from there.
>
> Signed-off-by: Andrew Chew <achew@nvidia.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>


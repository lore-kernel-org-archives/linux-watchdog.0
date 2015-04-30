Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:36955 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750878AbbD3LRg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 30 Apr 2015 07:17:36 -0400
Message-ID: <55420F25.2080205@st.com>
Date: Thu, 30 Apr 2015 13:16:53 +0200
From: Maxime Coquelin <maxime.coquelin@st.com>
MIME-Version: 1.0
To: Lee Jones <lee.jones@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <devicetree@vger.kernel.org>, <kernel@stlinux.com>,
	<a.zummo@towertech.it>, <david.paris@st.com>, <wim@iguana.be>,
	<linux@roeck-us.net>, <linux-watchdog@vger.kernel.org>
Subject: Re: [STLinux Kernel] [PATCH v7 2/9] ARM: multi_v7_defconfig: Enable
 support for ST's LPC Watchdog
References: <1428590854-14095-1-git-send-email-lee.jones@linaro.org> <1428590854-14095-3-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1428590854-14095-3-git-send-email-lee.jones@linaro.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org



On 04/09/2015 04:47 PM, Lee Jones wrote:
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   arch/arm/configs/multi_v7_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index b7e6b6fb..138e68a 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -324,6 +324,7 @@ CONFIG_WATCHDOG=y
>   CONFIG_XILINX_WATCHDOG=y
>   CONFIG_ARM_SP805_WATCHDOG=y
>   CONFIG_ORION_WATCHDOG=y
> +CONFIG_ST_LPC_WATCHDOG=y
>   CONFIG_SUNXI_WATCHDOG=y
>   CONFIG_MESON_WATCHDOG=y
>   CONFIG_MFD_AS3711=y
Applied to sti_defconfig-for_v4.2.

Thanks!
Maxime

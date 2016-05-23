Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:51421 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992AbcEWW3P (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 May 2016 18:29:15 -0400
Date: Tue, 24 May 2016 08:29:12 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	x86@kernel.org, linux-next@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 1/4] isa: Allow ISA-style drivers on modern systems
Message-ID: <20160524082912.258a5405@canb.auug.org.au>
In-Reply-To: <69b27a61a2dbaabdef53efccbabf5dda5687bf4c.1464029828.git.vilhelm.gray@gmail.com>
References: <cover.1464029828.git.vilhelm.gray@gmail.com>
	<69b27a61a2dbaabdef53efccbabf5dda5687bf4c.1464029828.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi William,

Just a small question ...

On Mon, 23 May 2016 17:20:01 -0400 William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 0a7b885..6601912 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2439,6 +2439,16 @@ config PCI_CNB20LE_QUIRK
>  
>  source "drivers/pci/Kconfig"
>  
> +config ISA_BUS
> +	bool "ISA-style bus support on modern systems" if (X86 && EXPERT)
                                                           ^^^
Is CONFIG_X86 not always true when processing this file?

-- 
Cheers,
Stephen Rothwell

Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60346 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782Ab0IRAiy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 17 Sep 2010 20:38:54 -0400
Received: by wwb39 with SMTP id 39so1516336wwb.1
        for <linux-watchdog@vger.kernel.org>; Fri, 17 Sep 2010 17:38:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1284764008-19469-1-git-send-email-timur@freescale.com>
References: <1284764008-19469-1-git-send-email-timur@freescale.com>
Date: Fri, 17 Sep 2010 20:38:52 -0400
Message-ID: <AANLkTikmfd=2N3GE1zpTqQ59583EEe1PDXggwHBUAj_5@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc: export ppc_tb_freq so that modules can
 reference it
From: Josh Boyer <jwboyer@gmail.com>
To: Timur Tabi <timur@freescale.com>
Cc: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org,
	kumar.gala@freescale.com, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Sep 17, 2010 at 6:53 PM, Timur Tabi <timur@freescale.com> wrote:
> Export the global variable 'ppc_tb_freq', so that modules (like the Book-E
> watchdog driver) can use it.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> This export is necessary for the Book-E watchdog driver to be compiled as a
> module.  Since ppc_proc_freq is already exported, I figured it's okay for
> ppc_tb_freq to be exported as well.
>
>  arch/powerpc/kernel/time.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 8533b3b..49aa130 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -163,6 +163,7 @@ static long timezone_offset;
>  unsigned long ppc_proc_freq;
>  EXPORT_SYMBOL(ppc_proc_freq);
>  unsigned long ppc_tb_freq;
> +EXPORT_SYMBOL(ppc_tb_freq);

EXPORT_SYMBOL_GPL probably, no?

josh

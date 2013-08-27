Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:59251 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653Ab3H0QFU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 27 Aug 2013 12:05:20 -0400
Received: by mail-ob0-f173.google.com with SMTP id ta17so4966874obb.32
        for <linux-watchdog@vger.kernel.org>; Tue, 27 Aug 2013 09:05:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1375872531-24992-1-git-send-email-sachin.kamat@linaro.org>
References: <1375872531-24992-1-git-send-email-sachin.kamat@linaro.org>
Date: Tue, 27 Aug 2013 21:35:20 +0530
Message-ID: <CAK9yfHwNqrpyA4xUNp_ZKhhQisybhTv6RRWEkxz3vgR564jx+A@mail.gmail.com>
Subject: Re: [PATCH 1/1] watchdog: ibmasr: Fix incorrect placement of __initdata
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 7 August 2013 16:18, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> __initdata should be placed between the variable name and equal
> sign for the variable to be placed in the intended section.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/watchdog/ibmasr.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/ibmasr.c b/drivers/watchdog/ibmasr.c
> index bc3fb8f..e7e7720 100644
> --- a/drivers/watchdog/ibmasr.c
> +++ b/drivers/watchdog/ibmasr.c
> @@ -360,7 +360,7 @@ struct ibmasr_id {
>         int type;
>  };
>
> -static struct ibmasr_id __initdata ibmasr_id_table[] = {
> +static struct ibmasr_id ibmasr_id_table[] __initdata = {
>         { "IBM Automatic Server Restart - eserver xSeries 220", ASMTYPE_TOPAZ },
>         { "IBM Automatic Server Restart - Machine Type 8673", ASMTYPE_PEARL },
>         { "IBM Automatic Server Restart - Machine Type 8480", ASMTYPE_JASPER },
> --
> 1.7.9.5
>

 This patch is not necessary. Please ignore it.

-- 
With warm regards,
Sachin

Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3491C489FAD
	for <linux-watchdog@vger.kernel.org>; Mon, 21 Sep 2026 14:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000486; cv=none; b=EjxIVUGhJiw4xBTtF1kFuyMa4+WjHjgqXl8g2iaRBJcWaWMVduiMV0NbSEhcJ6QE3kqTfeX017VXyQAN+Hao0AUNulmisJFpMak6QT8c7KZCOGG6llMj+iiFlxXk/znMh8mC8gXpaQA85nEN41Hm3wdbUYnxKS+56PbziMH289E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000486; c=relaxed/simple;
	bh=fDZ7Y+/PHoBhbrBgEHy/q78hWyfLtpkUfN+TYct4+zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/my+6W/iDqv0kQAwMnCp8a/oeoOATNsIPfVcjNa4YbJkrxX+Aw7w3Z9qG3PQqK6n3P59/LDXIZccBG5UopQsu7Znf3BkXB7rbvdOr6Q1dVyXEolpsiZF4seK7TE9YykT75fmZD5hGKraf00lChID1NRdMC53+mh4K8+C1dABQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHPyordN; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHPyordN"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8633a38df87so1923971b3a.2
        for <linux-watchdog@vger.kernel.org>; Mon, 21 Sep 2026 07:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790000484; x=1790605284; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GdFFJt1z3eO7q62w5AdGlpSxf6HIiDDYe+VNZfL4qBk=;
        b=iHPyordNYec4jtmNWankMvSDOLhaHd6v5VucG3fGeVNlS5tZia4pf8F7Ongf+U29bJ
         /+2wu7w7m+8Yx8/E+UHSA/223p4oEDuNHtWhHRXeq3qJcfvg+dy+nPD4UareEt+w6zJi
         f/iS4bBfwlP5/2WZ5GCNtPn7+w/q7YiYV3y+8c0/pZP5iETwpPG/6hKT0jfaeLlt6zlh
         SaNi3r2LWBNo8igSdkG4f2aiHnYb1r6lBTwzOfVrOM02W+5zP4/Ohi26fuLmE1gR+PP4
         YK/rZ39gqCftusfcI0cJ1HTkK9sEssBQC6VwR2VvqgMYQLJH+QMyCJNm/3D3/VsSV9bE
         aZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790000484; x=1790605284;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GdFFJt1z3eO7q62w5AdGlpSxf6HIiDDYe+VNZfL4qBk=;
        b=Sy8CqZjFi9ClqwrdKZrKOuTtXsLOSmlWhC8KTQNjMMQOMizrXMPZBL8JN4AiA7qRfB
         93louzXeyyrG/F+7qiQyemCduA3fH45FK5xw5G90FGGJwRbHMCs/xWsznF9Wd+lO/vVd
         G0WDllxf0DUi9IlRG6+781437aNFxmCygvDOI137ZiwWhKDR/KOWpO+TGEIYOjEnkxPL
         C2blVgkc9L2GMpgbgP/mPsMaOxOSUAG1JfPJr8MLNxpn/noX9Pyvn/kyowPtt1pLhISo
         AZQ09HkpdXZDVO6js4GMI5CyCqQPigQ1H8b3YJvaIoUpRf4xqyGxYtUyWcZwXdB3zFVC
         Maag==
X-Forwarded-Encrypted: i=1; AKwUvBwda+3k/KuwP/QcFNUKm6+CeLVi90C+TKBelmmWvKKxs5EUVsYu/rXveMNXD1w0/XGYUodYVBkLjQ01784SpQ==@vger.kernel.org
X-Gm-Message-State: AFuF++njT+GUqvcgRw90XdD4cQsDm3YsiRLUVjjpg22BfZ/CyggO+vSD
	6+qgmDuRvmvB3vnIBLITfuHj9QMHDf91TdCiQwfOMcM09wX+MLBanZcN+x4sPNnX
X-Gm-Gg: AYBFou1RRj9zE0tBNVcIcWAiWF+UnHHAPFqygPYJVZ17D6C7BsBoaTX4N4DQBsExy4y
	tWsZOWYOlgGVGKlo5PwjJ/WujJrLfIHcJqIOBp6mfeUGOK1Nj/833F2Fz3+0m2xR8lgG15e/SUG
	ZbO83WVeugn64eEgRzTa0OmCs0IK4bXXAU18M9FEf4oylhAkSAM0gnHRD513+bEsyFgPdF3CkeS
	vIwsipeLGPtXP1O5NAyx50qGHPFYPHln8zUe5zfYrPkM0Mgz0RtT95RagYlgo0KSltGIuKlmjr8
	KcFTI14GHAaA0j4e3bte2tZKxIN21hr92NkIwf6ftZHPhKM+45qd6bWc59D0vfmuyXT5Y/KkVY8
	nXf+KNU7IPsaeL5YQ2TQr/PHkEMzxV1S6CmkY9p1uzKpJNKBsUWv/iXGH2cxPPEokpzY9QLxfD9
	NLxL+GH49ODIESd1AGvKU6yvwwUeWVvEuC1cRkJcolzJEUKpU9MmnqSfeHzjpMXnWxlJv/1eDsX
	akwlRJD/GaY
X-Received: by 2002:a05:6a00:22c7:b0:874:708d:b632 with SMTP id d2e1a72fcca58-874df10529dmr14769511b3a.30.1790000484444;
        Mon, 21 Sep 2026 07:21:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a95eceb2sm3342432b3a.24.2026.09.21.07.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 07:21:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 21 Sep 2026 07:21:23 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: =?utf-8?B?5p6X5r+s5ZOy?= <m18667909625@163.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] watchdog: use kstrtouint to parse softlockup_panic=
Message-ID: <7b91e8cb-d068-484c-9a9f-2c19cb37f5ba@roeck-us.net>
References: <20260921064143.81420-1-m18667909625@163.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260921064143.81420-1-m18667909625@163.com>

On Mon, Sep 21, 2026 at 02:41:43PM +0800, 林濬哲 wrote:
> simple_strtoul() is deprecated. Replace it with kstrtouint(), which
> also reports parse errors back to the boot process instead of
> silently accepting garbage.
> 
> Signed-off-by: 林濬哲 <m18667909625@163.com>
> Assisted-by: AI coding assistant (disclosed per kernel AI guidelines)
> ---
>  kernel/watchdog.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index e5134ad7b663..420f08140713 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -17,6 +17,7 @@
>  #include <linux/irq.h>
>  #include <linux/irqdesc.h>
>  #include <linux/kernel_stat.h>
> +#include <linux/kstrtox.h>
>  #include <linux/kvm_para.h>
>  #include <linux/math64.h>
>  #include <linux/mm.h>
> @@ -422,8 +423,10 @@ static unsigned long soft_lockup_nmi_warn;
>  
>  static int __init softlockup_panic_setup(char *str)
>  {
> -	softlockup_panic = simple_strtoul(str, NULL, 0);
> -	return 1;
> +	int ret;
> +
> +	ret = kstrtouint(str, 0, &softlockup_panic);
> +	return ret ? ret : 1;

Please read the documentation (or ask your AI to do it).

/*
 * NOTE: __setup functions return values:
 * @fn returns 1 (or non-zero) if the option argument is "handled"
 * and returns 0 if the option argument is "not handled".
 */

There is no means to "reports parse errors back to the boot process"
from __setup functions.

Guenter

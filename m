Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FD63A6F11
	for <linux-watchdog@vger.kernel.org>; Thu, 30 Jul 2026 21:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785448187; cv=none; b=aLtLtWIl/7ziXIEGi/ALMWmv4wwZjkL7WmHT9W2hpwxnVGGsunqIGlcs8XyZ7fzg0c6cXtAIQe6/X0nmREuE5OEQ06qLzq8zjBo3sS6PqrseaCYh9RhfVeZTOZrf5EMydkh0AoqCK9ng3lgWzwMeGi5PO68eW1RVypraQXYsdhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785448187; c=relaxed/simple;
	bh=lx0FGf5TmIOgBSRTo5B2LdRy2tEopY15uCgKfmlb5gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hzfys6H1pPKOF6MCVtTcgtSKXb0lmwkEosrr6yEGzuupPF9GhMnY9Anyfxu5LLoV1rb2IrcwtNm/H1YSFE/XCJ5IWqidy8eBtJRR2DMG7BiH5VIZy8bvhASvIRlfZ2DQOSKOLmWconIC3/RNR6FK9KrC7wm+3fBwzThI42R1SPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aMaQIOkF; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aMaQIOkF"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5bf5370d38fso159575e0c.2
        for <linux-watchdog@vger.kernel.org>; Thu, 30 Jul 2026 14:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785448184; x=1786052984; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tad7KNNYJZEBGqiqlpXRjVKHZPLRhBKw+ZwCMBqoTfo=;
        b=aMaQIOkF9OWPOotIM8FD1ZdqTOm5/tg5jDeef4zUp4Z9eMAC3RXZOLevXznMy9WwOe
         idllwxtYxG8pUwModD9gRwKmROO35ZTmaQAeihjpnaSL9ottYRYbtmIVqPUbq3G1HPoI
         /wG8MJ6FLMywqVczc/BawCQLB8kBrO3/PGxs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785448184; x=1786052984;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tad7KNNYJZEBGqiqlpXRjVKHZPLRhBKw+ZwCMBqoTfo=;
        b=CE/bEew817F6z7Wlrdni+wKUz1miAXK4BfP9P0c2afgXRjaA31wv/VHiNof3pw4e9a
         41DKNwp9xOtW2NQGazEmbr5JUm0/Yu1fFOTV5LDgOcZilS15sGwsWGLg4+RxNMHURSTN
         XxYUBEQCF7rDg8IoMnapfJrJvbl459dhvjqTFsS1Mrww7O5MkBLujGPxGTGhWUEblOaK
         SijkRXmXswewCBTv/ap+Ta445s9+B22CIu72GMf6Ue+3bBFuRpZLZ6AF66X6EYrVZz8W
         BapF28TlkLBURuE9DMlh5PVViwekaPpqrUix1jEnQu9TBnX/9NDsW/GSxA8foXXIwptX
         nrVg==
X-Forwarded-Encrypted: i=1; AHgh+RpbmZE776PiP2P/+eFtJIXe3Y0bJCbfYbrouRmOFaFh93E4esWnpVQJJJHOdzGjFPDoYLwN2PQtKYP5r7RXDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgjAdSRSsSliZRu/RDp82PKHtdZejizOU5oNex9vVNmirpv/QY
	x3yjYhs9cDrJMN5cBw3GrlIua68RNk1dJ8n0y2RzysDfQ+5xOYc0iArfcQWej07YNKwnUprNbu2
	Erfw=
X-Gm-Gg: AR+sD110ihlAG93IgRthuFc0QOxi1rzrGMxe8loit2K/Ug5vFknl+8DTNZDcpcOzpwt
	D+YjJfgjm0u7zzDNTlJ5LmP6sj65JZKTisl8A8CH1wDaGoHEz98C4/+yU1cYVJ8TO5q1pedcIQu
	6TN9TwUU+0ux1Ai/OfUYKknb2hAOvcnzLiN1qtPqoXgt9yLuigCsfXq3EcLlmKypzkCWc2JC8Xh
	btv8t77pFsW/TSs7UQYSUsEflHJvA5bfDf+Vg9eBDLOPmOY+JlSbMCNiO/K1JfK+VbSeMjO4jbV
	nxGAEOogEdo1WygvdDPbznQYoybiShnojTp7Z0+Gx848av09cnye3pOo2oWLh4kkFTB6UalWwYH
	wkv6PTHjcR37atBb4wycJAWvS9WLjbJTuk2P9efnO3GjR5p9T6XcqWnwgGciFhhbY1ykzna5lPX
	4iLnKO0Xg7w2YdM7KTGGZP6iSZmtJuneGtSTJr4yqyjVkUCPd44L+0Vkw0UYuelPgooG3hWyt1P
	wCROf4H5jmc9jcDxwRsI35otPQ=
X-Received: by 2002:a05:6122:378b:b0:5bd:aba5:3830 with SMTP id 71dfb90a1353d-5c365d78356mr1364061e0c.0.1785448184083;
        Thu, 30 Jul 2026 14:49:44 -0700 (PDT)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c3666d8b61sm2461100e0c.11.2026.07.30.14.49.42
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 14:49:43 -0700 (PDT)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-754ac74c495so122723137.0
        for <linux-watchdog@vger.kernel.org>; Thu, 30 Jul 2026 14:49:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoZQL2vtlWm2iDnD//xquZoZXKFC5gazX65CRAqtUOCfRECmla+72CfYQHBM6+/lzHtr66kNM+79wRNv3quqA==@vger.kernel.org
X-Received: by 2002:a05:6102:3e85:b0:73e:9fae:5841 with SMTP id
 ada2fe7eead31-7575057a17dmr1646770137.29.1785448181666; Thu, 30 Jul 2026
 14:49:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730-qcom-wdt-nmi-series-v1-0-3aa86d162914@google.com> <20260730-qcom-wdt-nmi-series-v1-2-3aa86d162914@google.com>
In-Reply-To: <20260730-qcom-wdt-nmi-series-v1-2-3aa86d162914@google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 30 Jul 2026 14:49:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V+nrmtK6FJ2G+LGnvxkLEWMR+2A253-gQ2smxf9LoEWg@mail.gmail.com>
X-Gm-Features: AUfX_myzYDcjOimdsQMJqbaAJeswgkX9PwwN6ZxD0rYVoVz06zk8N3Y-SCHwA60
Message-ID: <CAD=FV=V+nrmtK6FJ2G+LGnvxkLEWMR+2A253-gQ2smxf9LoEWg@mail.gmail.com>
Subject: Re: [PATCH 2/3] genirq: Export NMI APIs
To: mrungta@google.com
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, 
	Thomas Gleixner <tglx@kernel.org>, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	"Kirill A. Shutemov" <kas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 30, 2026 at 2:33=E2=80=AFPM Mayank Rungta via B4 Relay
<devnull+mrungta.google.com@kernel.org> wrote:
>
> From: Mayank Rungta <mrungta@google.com>
>
> Currently, request_nmi(), free_nmi(), enable_nmi() and disable_nmi_nosync=
()
> are restricted to built-in kernel code because they are not exported to
> loadable modules.
>
> Export these APIs to allow loadable modules to register and manage NMIs.
> This allows watchdog drivers configured as loadable modules to register
> their bark interrupt as an NMI.
>
> Signed-off-by: Mayank Rungta <mrungta@google.com>
> ---
>  kernel/irq/manage.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 2fbff2618a1e..fb0b8da32f4c 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -766,6 +766,7 @@ void disable_nmi_nosync(unsigned int irq)
>  {
>         disable_irq_nosync(irq);
>  }
> +EXPORT_SYMBOL_GPL(disable_nmi_nosync);
>
>  void __enable_irq(struct irq_desc *desc)
>  {
> @@ -833,6 +834,7 @@ void enable_nmi(unsigned int irq)
>  {
>         enable_irq(irq);
>  }
> +EXPORT_SYMBOL_GPL(enable_nmi);
>
>  static int set_irq_wake_real(unsigned int irq, unsigned int on)
>  {
> @@ -2080,6 +2082,7 @@ const void *free_nmi(unsigned int irq, void *dev_id=
)
>
>         return __cleanup_nmi(irq, desc);
>  }
> +EXPORT_SYMBOL_GPL(free_nmi);
>
>  /**
>   * request_threaded_irq - allocate an interrupt line
> @@ -2342,6 +2345,7 @@ int request_nmi(unsigned int irq, irq_handler_t han=
dler,
>
>         return retval;
>  }
> +EXPORT_SYMBOL_GPL(request_nmi);

This seems reasonable to me. One thought I had was that we could
possibly get by with fewer exported symbols by changing
disable_nmi_nosync() and enable_nmi() to "static inline" functions in
the header file. That being said, what Mayank has here feels slightly
better to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

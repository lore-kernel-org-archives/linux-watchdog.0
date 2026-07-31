Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09098305679
	for <linux-watchdog@vger.kernel.org>; Fri, 31 Jul 2026 01:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785462926; cv=none; b=g2EfllujFN5Q12htqBI97FFC3gBkBJ3S20QKhkZyoviHPUgxfHBWu0sI3Um71d04+AC699y2phEo9CjV1IXaY6/ptwcO/yJlujbYkd7WBVsALP9mBUVe+r0KqBJ8nugja0V840erDHxW2BA6gU4B1iwY0vuN5gT7c5Qtw7O8dKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785462926; c=relaxed/simple;
	bh=kKokEKApBhfeDUDGCvc9tnerjL9g9I3yrVIAaF+Lp5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIj6zZ6llYnkkOeXZGlmbr6vpSPd+58731ssnfTFZ8M5w+paEmsz/k5Ll6rewj5HhZR3fjy8VZ5IALzCOj1R6AH15bDFAunCOiEDqeFj8S3+GoFVuJqrTb4oFqu5Hn/yEB/Vc1wx5BdqP2tXL8urVWEoCHaimGKMZlWKA8kU4QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dm0nnWor; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dm0nnWor"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5bf959b820cso334687e0c.3
        for <linux-watchdog@vger.kernel.org>; Thu, 30 Jul 2026 18:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785462924; x=1786067724; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WGnt/9N3yJKJH6c7tNU1dd0f/IV2+Dp7VlT/yFQk8Yc=;
        b=dm0nnWor7DKGGtR6jbtgU9qFJyjZeMfPFBAzVKXUyE/RApdObNKp7gBYHF558WY5Pm
         1RHd5yWM0MekjVoDqfn8yp2TGuxKPheFhgqWgjHUMc5Fuy43TnbIUmlUXhZw0/0ojoRv
         H/aUQrjP8dZOxx4xwN98SENyaiWqATx8E1emI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785462924; x=1786067724;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WGnt/9N3yJKJH6c7tNU1dd0f/IV2+Dp7VlT/yFQk8Yc=;
        b=VcbGGGrMNeo5sNMPHvGe2KMPYm0NmPScGVWhl6UjNR3MPN39vzFBStcstAT3if51+5
         yy7L7WWYefvi7oX45+Vb2E61NAPSYbaKkPmrMd/P4Jd9NYgzY+JL31t1LlGjuAUgTDtM
         LWJmcjFWc+JfRyRTgkccnzMOar/D4S1hY/3XjhfObXsgwNUFDS0n1g8IpvPpNSyHWBHZ
         JSLDHdm2fmbMzcodcW7iLvt063WqNpj8SAWXyeLHyFCfWUe7EN3OY9Lr26ScVXQPdsqL
         XdW8DVKBQc5AUNG6tmvBCXRNqxjODTnMGLUtPR7YwknF4GOjPT9iXblHjl1V7exkaVGG
         FH1w==
X-Forwarded-Encrypted: i=1; AHgh+Rq1fTvyOw4YPGgNXDdC2DPr2Hr1cGMwZInDoIWoieOBbxb1oxy/VOEDR5wr3cwWCyTl3s9SYu/dBJe2ijsUvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfHsVyJx6XKTH0Rwas1vDQF6Sb6kjOvKtP4coSiahBdgHNF67p
	2K43dcwR8oXR84GMJYAvdm7eraC+wqkJI/8VX7jOXCKLC68LWBMPMy5acq3IcpAOlMQKo9GuqkM
	ga3U=
X-Gm-Gg: AR+sD10YIHeYN67ZoT+/ToclGBz+9KmZv6Bz+o6L7nkc+Yt/Qit1pEJWI7isO+P01ln
	Eah5E1J7RLUQ3XbP7LSYMUSn+EPGSpuCoNcTh/G/JxTt918ajRNs3+zA8n93d1xllfGbmJF7Gwa
	P4FPgTx8lrBXvSp2/wXiNOYC1MPpdte1SpLeizO/9DtI6Keh59SpaSA6QiBrLjp0p8F0YT/0opO
	14ONasTbxBOzjHGHuoHK4IHXKni7Tg0082r8ep/OJ3jSoKTOOSgeg1GaAqMe6GowpIxD1QbjKXt
	JkXA+dFq9etiwmaTM6lH44KbwzVbRwKNi3q9GXG/lLpmRQZILOjFXHBaEoty/5r4HTI5znhSX6O
	1/VKhA/OPyX8uWtMiPv30VlCd++/Vsx/AAJMOI/L63EVIok8ZxR9/2eO3hSMiEchAKzX/jw870V
	v3Ws1+RcYDwgfmvcY+g/VkkPTA8wfW3jBff/1UPByeVNeTsMnFSTJc0B+Kzx2ENwWS6lJmRj60r
	NG0LReqsjrw1qAvJdMlkGvuJVaXZGc=
X-Received: by 2002:a05:6122:4892:b0:5c2:d11b:dfbc with SMTP id 71dfb90a1353d-5c37e3b5185mr20804e0c.7.1785462923925;
        Thu, 30 Jul 2026 18:55:23 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c366568458sm2869143e0c.7.2026.07.30.18.55.17
        for <linux-watchdog@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 18:55:22 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5bf959b820cso334648e0c.3
        for <linux-watchdog@vger.kernel.org>; Thu, 30 Jul 2026 18:55:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro+3a1naIJBhPwDajI+iOGRuwVpA8gtB0wt3LbEk+vPRDaoHT2y6lEffpqIW/rSVhJga2IbQqN6+P8xXc1suQ==@vger.kernel.org
X-Received: by 2002:a05:6102:3f53:b0:74c:7fd8:73f5 with SMTP id
 ada2fe7eead31-758f8965e31mr9865137.6.1785462916714; Thu, 30 Jul 2026 18:55:16
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730-export-cpu-backtrace-apis-v1-0-bace8e1cb817@google.com> <20260730-export-cpu-backtrace-apis-v1-2-bace8e1cb817@google.com>
In-Reply-To: <20260730-export-cpu-backtrace-apis-v1-2-bace8e1cb817@google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 30 Jul 2026 18:55:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VaZJPs3m+QP34+v0XSboYsGbBqEs4M7EDQbTXh5QJC6g@mail.gmail.com>
X-Gm-Features: AUfX_mzo7W3pvmnS9mL8sDrAgHUc5JTVkUI1izvsxOilY1cg6ckoFmOpnaMqAlw
Message-ID: <CAD=FV=VaZJPs3m+QP34+v0XSboYsGbBqEs4M7EDQbTXh5QJC6g@mail.gmail.com>
Subject: Re: [PATCH 2/2] watchdog: pretimeout: Convert dump pretimeout
 governor to tristate
To: mrungta@google.com
Cc: Andrew Morton <akpm@linux-foundation.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Tzung-Bi Shih <tzungbi@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 30, 2026 at 3:00=E2=80=AFPM Mayank Rungta via B4 Relay
<devnull+mrungta.google.com@kernel.org> wrote:
>
> From: Mayank Rungta <mrungta@google.com>
>
> Commit 645ad41da8b2 ("watchdog: pretimeout: Add "dump" pretimeout
> governor") added the "dump" watchdog pretimeout governor, but restricted
> it to built-in code because trigger_all_cpu_backtrace() was not exported
> to loadable modules.
>
> Now that CPU backtrace APIs are supported for loadable kernel modules
> via cpumask_backtrace(), convert WATCHDOG_PRETIMEOUT_GOV_DUMP to
> tristate. This allows kernels to deliver the pretimeout governor as a
> loadable kernel module.
>
> Signed-off-by: Mayank Rungta <mrungta@google.com>
> ---
>  drivers/watchdog/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

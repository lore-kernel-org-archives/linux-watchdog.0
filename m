Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D41516171
	for <linux-watchdog@vger.kernel.org>; Fri, 18 Sep 2026 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789753190; cv=none; b=ojZVX0l6c+NEPuBt5YKX5ME11PNNvzo9n/APTm4xRXZ4GaRdqRlWWUZL0JT83nn6SiOIDXDtRVxQWdB/jOMrxst4zsdwhMbSFr03aiDoXyv5TYxsi3m44/t4tAnXEJN9xk3fq7uoimUqtncF0zYS1fnZRQQfD6yB8OWnla9XYxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789753190; c=relaxed/simple;
	bh=MDiWz/AWqwWs96s+XjfNuGuDwtzStFIrTIMZMFLPOvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rvs+a6Gtkw2Eu/OrLp7Dt7HGoFucLV7Ua1ymjCSlFpfCLkUJffEnmy2YjurEgK9qu8lKafa84Hl3XGVi5qAIdamjU+cPWJgWMkY/fG8xmXREUUDfQywvkYhkjLdNn4LP4jKZ5Nh76AzzpbYzuLtmJ2nWrfx3rcasRCl9Mos8+9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LYctSQ5e; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LYctSQ5e"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b31b4281eso1118330a91.2
        for <linux-watchdog@vger.kernel.org>; Fri, 18 Sep 2026 10:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789753188; x=1790357988; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D5Ib5GKimOnmndCsEnEMx37Z4fKeBAXUAyL8zUhE3/s=;
        b=LYctSQ5eamvwAu1wqb4pieNFVBhr2nkmwhSZuNq+4xlX53Wv8LDzZyl2wWDABI9fc9
         zeDSa15Kje7Ld3qtk69zhZvJcTQ6AC0b8JzxkdPujDJrGj7AAEuWCWc102ebcPibjUT5
         HTKjXAizAkqkBlAkmn9vXJwz/hqujvqcZbi/oLQZ9HNi3STnPky6rd5zkqGI84FZLz2j
         oDq9bEG8sdtaVhCV39O5HQR8GXrtrQAGuVQD1e1poZWos3remaCEZZq1MbpmB89EPqJN
         vI9KKlVPQhUKXuXkuGAJh0VDVUzu9zg98U+2/4pOWIld+OXjP8XDtGUwjqeQfiiC3hzF
         AKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789753188; x=1790357988;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=D5Ib5GKimOnmndCsEnEMx37Z4fKeBAXUAyL8zUhE3/s=;
        b=rbBYIylW0+J41otVmE6TAYIACloUTL+wcgaCpu0DrOTweQaGc2WVxzKhFP9iBqgxMA
         R5pjZPXIdpcLuMMXifWgaYcyStPr1GCjpEuPO5fw1j9wokK0oBl+XLP94fF1w8kQ8wH7
         XN/iBKb1GN+CjJqeCFPRo2Zhfq5QbSaYhktMR/K9GGg2R/hGxe9uGI0vouD6bFyXd7aF
         Bixfi5HQqXjTsVydi4KAgmPF0vXvLcnlRCP7BrmbcE0VlEYNutOmm3xl5vyRAh128y0p
         RzbZ+sy1kVZkKRsz+Qq0JUmMTSyoIllZC9fJQExPV80Wecg6ho55wZvfILX5SWxa1eY5
         78sQ==
X-Forwarded-Encrypted: i=1; AKwUvByU9ojviLLpIq9zTKKpJVpr9oc/WB+SJclHLgB80FmPx+sKTndmGWx/6g0AvFAtUAULRuRbah4vgf/pgtFr7g==@vger.kernel.org
X-Gm-Message-State: AFuF++k6q7tVG6nP0YuDEkdeUZ2uFZcieM24nPMC+ZFA2PQJIQ8gpkrM
	TpsKdFVXDUZ6aMlGdb/lZ0Z6mgJEsnVrimKM2IefHa3kwo3PX34v3XVj
X-Gm-Gg: AYBFou3H8XMoK1cnPIAMFsJFvla/NBpSHWvamhXDVIwuaSaAJdm9Q9FT//33LBF3Lqt
	pfdOLQWywmX0bNBbacjseBN8n45jBq7t56D6i+VkarltxsAM/m5iXhyHyLttjCje2+H/A9zcIXK
	6oCazWySEwHx+hmVFtLRi3OZOEureqb03Lxjr8I/H/y3iztgLDeOEUEAMu27eESQhptxP4C9NFY
	GXSs4Gm10dHN/GykllpfpHNoC6tzFuEGBhfIInqdj1hnLxr8IBFsSiR/g395FVAK5koR01bPn6L
	VsZTqGjadr8oqehpfS/+vwI8yym2H2zgc/Il9D1f82FNBuCxFuYIQGjX48sWc+U4ILZwkEYAnRe
	+z4unENDU/6MKFsaU8rdKkfWk+VQK4oqZ+ZHlgfH00vg9DUw8RkK5fLA5rgqY1hWlSLUMfvAEt5
	9KQaSMUw0GnVviNHQMMb1YU72I/MEDgAk9qWX5QYZClfKlGmIbNps0UNUGg7jRBkIeLlwGe+byY
	yfkX8PTqyOdt4lBRl60zcgnJ+9iudsOaZs4cNLl4DaY84l1
X-Received: by 2002:a17:90b:3eca:b0:39e:6a7f:1dc6 with SMTP id 98e67ed59e1d1-39e6a7f2209mr952403a91.34.1789753187862;
        Fri, 18 Sep 2026 10:39:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6ca86d83sm441741a91.6.2026.09.18.10.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 10:39:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a73c5d5d-dd64-4061-83cd-0a1cdcc2db4d@roeck-us.net>
Date: Fri, 18 Sep 2026 10:39:44 -0700
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] watchdog: rzv2h: Add syscon support for WDTDCR
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
 Prabhakar <prabhakar.csengg+renesas@gmail.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260817192540.423994-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260817192540.423994-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <87577cdb-7f1d-4a9f-8a61-ff1f272234d9@roeck-us.net>
 <CA+V-a8vVtjALarck6PE3it1si2hNbveZWoGjTaTUW68Q6yYjcQ@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CA+V-a8vVtjALarck6PE3it1si2hNbveZWoGjTaTUW68Q6yYjcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 9/18/26 08:18, Lad, Prabhakar wrote:
> Hi Guenter,
> 
> On Thu, Sep 17, 2026 at 2:12 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Hi,
>>
>> On Mon, Aug 17, 2026 at 08:25:38PM +0100, Prabhakar wrote:
>>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>>
>>> On RZ/T2H and RZ/N2H SoCs, the WDTDCR (WDT Debug Control Register) resides
>>> in the second register region of the CPG/MSSR block. Since this
>>> multi-function block is shared with other peripherals, it is exposed via a
>>> syscon regmap interface.
>>>
>>> Look up the SYSC regmap using the optional "renesas,sysc" property and
>>> derive the WDTDCR offset from the watchdog instance index.
>>>
>>> Retain the existing MMIO-based access method when the "renesas,sysc"
>>> property is absent to preserve compatibility with existing DT's.
>>>
>>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> Can I apply this patch without the other patches of the series ?
>>
> I posted the v5 series here addressing Sashiko's comments.
> 

Sorry, I was getting confused. I somehow thought they are different series.

Do you plan to send v6 to address the issues reported in v5 ?

Note that Sashiko no longer reports pre-existing issues in public,
so those will be out of scope.

Thanks,
Guenter


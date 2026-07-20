Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B183F58DC
	for <linux-watchdog@vger.kernel.org>; Mon, 20 Jul 2026 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784563830; cv=none; b=EeOE/ZLbfDuQgI3UgCEQ0pU3Ldddb9/Qw19AJaaeh+b+hIoHsk58mpbNTGj7GkIzoFTpg2RQ9vIkT5hHaf+yX6rqrnkXd6jQtfbO/KT91HUv6CVTwylsRyowk593rk42HPRIgIIeqqpMwJawvY+4BoEZZnO4pqf4mlCLncog5/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784563830; c=relaxed/simple;
	bh=yn9KL+gzo5WCfpKnYQt/rCA8kAl47sae10Qk9mMRStE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IczmNkwur/gc+eDDAnryrmtEo6J3N+qDD1i23RfgCwuDuJvKriUKdKwgyCelidvDtoU+IsRzIMMHJSCAEij3obtsueqOBnHvx9X5McKwNOIfKcQFwV6BhxYxSQ3Oj7OCLsKJwVudWrIfH/WftSTytFbrcwtdGqouLloMDTknO1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jN+Ady4l; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jN+Ady4l"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cca0c5799eso79722885ad.0
        for <linux-watchdog@vger.kernel.org>; Mon, 20 Jul 2026 09:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784563829; x=1785168629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PlPWzBPmCzPImVf+9GWi56cJVlswcuLHqcL+2o3RaBo=;
        b=jN+Ady4lw17M5yDYEPMlSGKEZ+qyjVhv6foYaStiKaFZAWCpFexHglEllE3ryTrac7
         kAKEe1t6ZjhCgnEPkqdC9OrEsd4lefxlj3sXcgaRYr4lNc+p18OxbDseBDSbBumjepvP
         VMVtc7B3x/JeT/z6mNjCu1MhaWSK1PbtWH4VKm+KOtFEdfiTw/gGqPaXmUwp3QZUWFL5
         e+G2YWi9PjViEtcHUSPLUYrFFsdcMnpSqZgNAyZ4FOgEqNJeXUzscKVQEjLXmrgu+cDx
         Pnz06eW2Zc+XzYCkTW+/86+ZcVBTbyGk5KkBuk9guDRlB3z4ZlZ1ziwtws6Q4pM7dLim
         sbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784563829; x=1785168629;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PlPWzBPmCzPImVf+9GWi56cJVlswcuLHqcL+2o3RaBo=;
        b=rBPkvgnwp4qr/mRfVe4Cj/WmL8ieqCPQCyHTXobPzXhJumQKsaAlx/P753UDjbzVvy
         YT1wBywsBQShTJyMlVBtGafQyVnndT1BfcoCxPFYN5YLuJ9en7vIykXvRVckPZ144JK1
         olhcXSCtwFZRdWo4M3EBCVAHMSdhqLNUgcxL9JvH0AnkdCHIlRkvl4w13l0djmcT0/kp
         rbTgWprbnM+nogb9bMaWrVTpMGkSjvkgio5bEHp8A33wSX0kQqPjlEYdDYta8eZvSOR7
         LBJ3nom97v0paqF1EnNSTHjXDF21+dFozVGmVdP83jTDLYNtM/cz6jNfapUNHKMgph1K
         Xcag==
X-Forwarded-Encrypted: i=1; AHgh+RrivoGS1NuVHGGvIUcJ3FAE1DJAYDrAuvuV7VCyrayYrGTUwyJTJgro3SKPOatFHqZQlxLFDjhDHVMBv7jK3w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0AO1JPfQ7HQysyGDW1hSLlfffAH11oaGxHYcJasNAPL1ztdKL
	QF4Icl8IEFchUJKQql2wPe2b2KbGi5fw3k2QgASr5yi68rT76PjAM/m5
X-Gm-Gg: AR+sD10egVMDYQPKQBxO6S3rxXV8/eKk8XdMKzXaJUHZe8biMF8Ri6uR8cxiSOe7AUl
	Fivta6KyP8c0fY/Udz/hmChl3PwYNRzLHSIUuE6Kxn00xQcS8l7odxLJa9iMrMOf1ExVD8qYAEY
	LdaDn/vA1JXFGE4DNA9FVS0j5N7EiEehATIfn+ILesdAsW6W0tF4XVlmGGVI2TeLq7mJ3cTeQfx
	rT+77xllMeZ33MdX8WPG5tLSKSo9huyh8//XwLXxqUWLyhC4RzmIP/F7KMxpSSMsBM8i6ywL7Ef
	rbYTdC+IzqaiNT73LJbR/YC30XEYB+ZdNqSdoGmEfecpGIboFCu51SBPgncHJ/2L7Gm0t/t0pVr
	kzi4/oMlHwSpjFefES1cfK/NcIbf+ePARylf1odKdeIcM/MBZ731nEN8EErC61gJi61ThwU9SE0
	ElhE7ZfyYQapXwwO8RAOq+FHjhdA==
X-Received: by 2002:a17:902:d4c5:b0:2c9:2ee6:693e with SMTP id d9443c01a7336-2cf34873ddfmr177182215ad.18.1784563828753;
        Mon, 20 Jul 2026 09:10:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a20b037sm40185272eec.27.2026.07.20.09.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 09:10:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 20 Jul 2026 09:10:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Tomer Maimon <tmaimon77@gmail.com>
Cc: andrew@codeconstruct.com.au, wim@linux-watchdog.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, openbmc@lists.ozlabs.org,
	linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	avifishman70@gmail.com, tali.perry1@gmail.com, venture@google.com,
	yuenn@google.com, benjaminfair@google.com, corbet@lwn.net,
	skhan@linuxfoundation.org, joel@jms.id.au
Subject: Re: [PATCH v4 2/3] docs: watchdog: npcm: Add reset status description
Message-ID: <ebe0fffb-eeb4-4dba-ae8d-7153af6c2fbe@roeck-us.net>
References: <20260706144828.3517631-1-tmaimon77@gmail.com>
 <20260706144828.3517631-3-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706144828.3517631-3-tmaimon77@gmail.com>

On Mon, Jul 06, 2026 at 05:48:27PM +0300, Tomer Maimon wrote:
> Add documentation describing how the NPCM watchdog driver reports reset
> causes through bootstatus on NPCM750 and NPCM845 systems.
> 
> Document the reset flag mapping, the watchdog instance mapping for
> WDIOF_CARDRESET, and the NPCM750/NPCM845 latch handling. Also mention
> sysfs bootstatus reporting when watchdog sysfs support is enabled.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

Applied.

Thanks,
Guenter

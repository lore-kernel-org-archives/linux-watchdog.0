Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093803876BE
	for <linux-watchdog@vger.kernel.org>; Wed, 23 Sep 2026 21:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790198351; cv=none; b=EBogFrPqBYHtw0JAhOj3KHhMBTc9GVPqgdufJTnk+6Sqx8NvbuJkaETf0nXPxnYIjWBNdH58bRLSD4d6akxvOiZWKgWA6wlSgAhu6vuELwBuBmCG6kBCSb/W8h/UuHOeNXyqemTTJXi2Yks3pMJYqCa38fTHNrAtcQCsO0jplF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790198351; c=relaxed/simple;
	bh=ZcbP3QeuLjyfA/MWPpI4xMkSD/R2NEkFhR/DwOlavZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlpExm/RMwf8prGlhPqTMKS7VeBsKV7sGNOPSBg+WM6DkJwg99xMWSUE20mEE8wrbG6igyOFikohAJqNOu2pXOyOpj43BG4rb4c8s1nkadLjN/JH+6I+5MPha4nMAGHdNjWmdgepji0nn5VtGsJB09mc+AzYBdOU2rZsZNXasEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAqepXK+; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAqepXK+"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ee1f9bso7588715ad.3
        for <linux-watchdog@vger.kernel.org>; Wed, 23 Sep 2026 14:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790198342; x=1790803142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mvwR1H5066c3VfNVVSSHz0oGUtnFFfkwQhyCaKNQI9w=;
        b=EAqepXK+ivUp1djsVH7gQb2y16ForKGGc2L1H1ROfrfTF3lw/SE94TuQ6gluhqEEmU
         jWJS7auLvn+Qjx2i6r14+sKc0dq/LDjKJoBspxwlEbczdmfv0UvHdYdfsdTunFI7EZ8s
         UJtnSI2eG3XEtqNfxOj9qJVaKjW6c6xp2ODbK8J+qAGdJbyoPUCQHieqFNcn/E7er28l
         Zy7RF6juD5wa6BdG3/ypDxoZVXmpaJdPaILCuWpNWOe1g9czALUSEDEyWtGiQg+uRI84
         3umQKoogRxkrab/tkNbasH4CA5BlFcKpCuZbNMsjmw+LUYTYFlQMJPk8xEnSQW152qL3
         IGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790198342; x=1790803142;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mvwR1H5066c3VfNVVSSHz0oGUtnFFfkwQhyCaKNQI9w=;
        b=Ske9ELqqZEJCt4s++xyn/w1b+6LPFXOjNeZVG6zWitMLBtxH696L8Bs+xjzCbQv1XO
         E4ogURmZQ5MjUBKxSFjEMq5WItmFeekK4pepfMEXEZdz/XAaPlLNhYst6AyfwXxlnrXM
         7UDIAn3JmFAJLda07PAykp5NZ9LST5PgE4ONVtvDEPu9E/EgZ9apg86R4Y3DKdY7zK7n
         xKfDiorDSctZ469mx10EIyZq3Cwk78Jqd2gzQQCsdC3JZ7DkQ0kVsFMC5w6nSEyc+Il8
         sbhkzq4TGEW0HnGuzPOYq6JU8XlD7/nIQK8wwYar/bivBuVjgHuaQINbxQ5LEkjkt9DM
         Qvww==
X-Forwarded-Encrypted: i=1; AKwUvBxp+dBlK1yjFQXYkXDp7rctKpCf1E7BUhiX5grBpj3bmRG0RrvODMQRwPOY4v+S6SyVLSqoxcX+AA/1H9YzjA==@vger.kernel.org
X-Gm-Message-State: AFuF++k7LFr9xfYk3Cnh8t+Zoz5thszkiFlQpdjpA0VSJ5jvj0B9/1uD
	w7uu/shlyJVN5n7dQoF+xjbwer2nDPecq9WyZjK6S41BvlClVAAz5t2h
X-Gm-Gg: AYBFou3c1JFm+mfgHhuxbWtZLh7mXy2CNeIeN2t4X/0FihMs13j5Xpk52h/niA7CGGd
	pPFMEXB/H7DwwMTqeVg6wuha+VIyF42ZSaGm/VY+nGONrMNCZY6mGO2KET5VZ1VcP+dbPeJcI/b
	jaEJowC2tFGLIl90RkLehEQnQTHvHCinfqpMVnlXHPUVrORZx+c5EmRYVvrj34ysY6tN0NEtIa+
	v9LCwtv6mkhayKf+2WsOyZzel+We993toVA/Rla/zsWU2RnjaWqImN9G/hG0ak9rtOBqxDoBjbb
	rftoZs69R9H6LGGWeBOe/HsIEFsYB4GgF2JkcWuCfF8zr+tn/qwYWh+hsLce1J++NvpIA6vUx3t
	SKt7GVgL0NtbAuOi2Q6QaM2hwO+iDangxBGPh3Ba/vXYh2d8Aa3dF+PyrSbE4ww61fbmLBDQbGl
	W5PLBEM33HVyd4hik2MoiegiRZpT5dYajBzvCizCfQSR7oe/G3M75BDHlBXORCTYgfECZHMxVnj
	L89L+6nfOkr
X-Received: by 2002:a17:903:1b6c:b0:2dd:c100:7cc7 with SMTP id d9443c01a7336-2df7dd74741mr2847775ad.67.1790198341935;
        Wed, 23 Sep 2026 14:19:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5ee5efsm16486245ad.63.2026.09.23.14.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:19:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 23 Sep 2026 14:19:00 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v6 4/8] watchdog: rzv2h: Propagate WDTDCR access errors
Message-ID: <999bd947-4f7f-4615-9ef3-c33b85182027@roeck-us.net>
References: <20260923104054.3324830-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260923104054.3324830-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923104054.3324830-5-prabhakar.mahadev-lad.rj@bp.renesas.com>

On Wed, Sep 23, 2026 at 11:40:50AM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> The WDTDCR helpers access the register directly using readl()/writel() and
> therefore cannot report failures to their callers. WDTDCR is located in a
> shared syscon region and will be accessed through regmap in a subsequent
> change, where register accesses can fail.

For real or just theoretically ? If for real, warranting the quite
substantial and invasive error handling code in this patch, this
really needs to be explained further.

Thanks,
Guenter

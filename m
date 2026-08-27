Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368CC37DEA8
	for <linux-watchdog@vger.kernel.org>; Thu, 27 Aug 2026 14:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787839349; cv=none; b=Nmkm74+KN9YJ6Zhori/y6mSkv9x7LWe46QkLzjaIAmtpL3aeUqeUEajkQkcsN67cswJ0EMU5P77u773gtioqpvxn3Fe5Cn1qhuUdFet2yxWlVf5rNX+nXLK6dDM+MfgTRbOosZJZ53DY5Vgy5XQf7Hi1MxTQy2PvLGQ8Ic55SME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787839349; c=relaxed/simple;
	bh=svxFq16jhgUwujetnMHf4NGpGV3nz/ISyT60/BUazac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tfb/cjCIy/7Pw0Td057kv//XyXAZWchKyHY93695hBNDK29i5xTrQKk0nbnxdQmAfa4MsedW4i4TtUVbvaVQdL2O/hnYoGEQlDwf+PkAl95bu/9mCMqT+jBkH4tthDPOA2+RIxZvAo4pbrcy5uvUxpBpipEiG3nlTuR5H7P4HO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUJ6aqgd; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUJ6aqgd"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-39686abd426so2062743a91.1
        for <linux-watchdog@vger.kernel.org>; Thu, 27 Aug 2026 07:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787839344; x=1788444144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eDQwLy7w6jGmaKdMCoLcam164nOHb3RGtOUt5TvcQcg=;
        b=aUJ6aqgdc7lB0MYT97zhFm3BKF4VbtAUUU+rIIKwxCq5DLh0YDVTxydMjSS98jsuz0
         igirDowxj076/mH1COYePoY1V9FOv/WRBYZzKhBL0q9uprhWrdk64lHN2wBlJHEYFJtu
         i9Pz/9Qn8rWil2mCwxv8yfFBsPmFU4njR6d7QKzkue2zZ0OHTveI4Vr6eFcMmvWDOd6J
         2gxaf7A0wg5vHnX/zUxkVbtGlpob0Omfv8nuKdyLfCZtbyqff2413FvB/Nwb2pd0Ijbs
         ZSohLWE//HNMvVy018tgKtob6dL9zUzRgmhaO38WMaSBZTFxOTGAkXarbvEjBwAJyh03
         zoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787839344; x=1788444144;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eDQwLy7w6jGmaKdMCoLcam164nOHb3RGtOUt5TvcQcg=;
        b=YZdSp5WoK091tJt4s8lgPkidXb0N6zo1y0rK2IebOuYkjDoG2srHo768qRx6Y0DNW4
         BfH54rSvqUHcZbqsFX3xqLPjejalSskaZUBcOIZNVP+uIvj3Z/zykas4p67+WNVswgk8
         vn+ajiap4t9chyPPsIIeR+DHCvar9OzTch2Cvwl9dlXgHkNdjGtwJGz6vAditYFFW3CP
         7oLBJDtCHi9Tm0X6pXR4J6VyB2nvmn1OQ1HciW3B6FpXnqC4hYmhGkJzM/Uc3A6ZZiOs
         Qa4WlSiB3O85ezhoE7jAX/aiu1kIDS5PmJEguT3By+2BK4p1Ee1ZG/FyHs9xsKJo09p/
         xLNw==
X-Forwarded-Encrypted: i=1; AHgh+RqnYzWpoj2t0QbUfSf4xPMQxbTqRoziT9p7L97XCX91PjSuyMKnuy5zH5h1iEbjpYwxaTPa5fd4cn+RaOyYjg==@vger.kernel.org
X-Gm-Message-State: AFuF++mVPkhMNIM2Nu3gQ6EYbE79FgDdQokilTbIwHrGd4SD0ftaXIuO
	xd5vC3kQI80wdAFU+EBQUPHNMq8xMmymD3Msbh3iXfO3YHq8pg4lyQX3
X-Gm-Gg: AR+sD12wP9pcLHqh0obKKOWVqZvZQ2MUI0fsi8J7rws/8k8+8PfdLqKKta9Vk0m1e36
	xf5JdoWhbq6IVm239OfKF88fWFyoOLzaUY0eJdwMBxf7uxpLhEfgvj/KSbJSehMSX6p7wg2HtXx
	3Vh5Ak8sqeO/a7zLh0nmgK9jbLKokqOKFnlHQRFIxzZx7lnYdKL9h4MaX5ua8nCMoSMzm25o4YX
	JaS25pmSWbV38DrpDnM/ZME3rL+3RyzmvPYAfySDBV6n6ZhfkJ/qNwJGLLN4P7C+wRDUUdjHpsg
	xB4rlsZsa6zhpqIRNRJsceEX9AATha3jnmImTDN2OAgWBTLl4VNQeBi4YT2qHEKhuf2WVJq9daC
	NcVrHCV1kaAxTdbhNRA1kaceFIx8b9fG4K6U5SiA8od/tMmx+6LZHATbezq1gTzark7gfSDLfVE
	nwTs1QCH8YQ/gIA4FQqukz6VYjhz2cXZeFDL9sehWXqilJASd4hKEOMjsv/m0Bn8MpvT9F23Hh6
	g==
X-Received: by 2002:a17:90b:4c8d:b0:395:4de4:92c7 with SMTP id 98e67ed59e1d1-3966d1443a1mr31804030a91.3.1787839344389;
        Thu, 27 Aug 2026 07:02:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396759cab6esm2023470a91.4.2026.08.27.07.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 07:02:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 27 Aug 2026 07:02:22 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v4 4/7] dt-bindings: watchdog: renesas,r9a09g057-wdt: Add
 CPG/MSSR syscon support
Message-ID: <9c9982cf-6fe9-4904-b75b-c0725db5073a@roeck-us.net>
References: <20260817192540.423994-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260817192540.423994-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817192540.423994-5-prabhakar.mahadev-lad.rj@bp.renesas.com>

On Mon, Aug 17, 2026 at 08:25:37PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> On the Renesas RZ/T2H SoC, the Watchdog Timer Control Register (WDTDCR)
> resides within the CPG/MSSR block rather than the WDT address space
> itself.
> 
> Previously, this was handled by including a second register range in the
> "reg" property. However, this is architecturally incorrect as the CPG/MSSR
> block consists of two distinct regions (0x80280000 and 0x81280000) that
> contain registers for multiple peripheral blocks.
> 
> Since the CPG/MSSR block is a multi-function block, introduce the
> "renesas,sysc" phandle-array property to allow the WDT driver to access
> its control register via this shared regmap.
> 
> Mark the use of a second "reg" entry as deprecated in favor of the
> new phandle-array approach for SoCs that require WDTDCR access.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied.

Thanks,
Guenter

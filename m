Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91EC59C966
	for <linux-watchdog@vger.kernel.org>; Wed,  9 Sep 2026 21:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788989105; cv=none; b=XY7VKwCnl8VfAP7YWL5RO6+oqzEJfx1iA2ujLpA4vEFUFc8gbBPc1zZCpIc6HeLWEf6+zWwf3BPF3f1yGYQrEMOwvOKIVKlskWe5qoQGlaa/clbeNRAcTRC8opSQNzC5fCIPydgGWQ5qhjmDJ8t6qUd2LU71LzqHa1xJG28NgyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788989105; c=relaxed/simple;
	bh=j/apqNvWLw9XnsOroqXyRHw69VQZFc9ZzUz7CVKUVzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWXbGS6+SE065CYEINvl/3PcN/D4XyLp/5l9diEHXHK286+jfSYuDN8adCqaBL3xhBnS3VYdMTv1Ig64HAhcMhoxOFNi+nRyyQ0kt1Tt/9oQG/a41nKWi5S21aIE9Okk9Ln1Wp7bGrz3JWKJ1v2DTZDIj9nQmx5p/EDdG6eiK4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4/Ex2KY; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4/Ex2KY"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso4918378a91.1
        for <linux-watchdog@vger.kernel.org>; Wed, 09 Sep 2026 14:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788989093; x=1789593893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sjwFGcVPSNWfje2QsRXKLC8B+AQNq5tvQ8diIKCovEc=;
        b=j4/Ex2KY4pCB/q6pnQ9V9zQDExHQuB7MCiBkMgO0TF/UZ6/ycuXEnRBzYJi7VC1ijK
         uIYTZvODvtKqPhxBOyZRBi63qay5BiljBU3m4F2KMDtH0N5str0FzrRCQpHYl5pIh9xq
         phhKb49l8LwAZhnsXR+M8/Eu3wLFAdsqd0/g8rT+Z0HBi1iePhPFSK+gw5MzvamBi+Ph
         aMAyPiNUYh/IW8sWUeHAJEKN65HL/39b0XbDI6BmZ+FXK9DYbMfItNaZ/hVILLyiJjjG
         PPrI+sKKjQ4kZiJkJs4IaOlsAObH+urZVB0nKaYvQ3EIvUyTg6+in7ggMWcIvU2dDgOr
         i97A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788989093; x=1789593893;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sjwFGcVPSNWfje2QsRXKLC8B+AQNq5tvQ8diIKCovEc=;
        b=eKw+AdBrfbEU3giM3TSRtqmZO4uTWoECW9+TXQzjN8lG8cA6yAQ/+2vz0SAdrlImZd
         x3y159fknhmQBG+b2s/OsgveQlGyRTfdpMCb17Y6abTHhUlhxeuQ63DSQUwCxgJrKqz+
         yWRoIrtFz2RJenraOtXgLirzjKfWhqjIHv8ubLJHZj04VGPSDogtmOsJFX5/g1AqnL3c
         ctwH6C2RoHPTxEdJLtPraEoBfGPzKbC1izXX5Sk5U5pZFBY2zV94BfOmvcZvOZgPw9Uq
         X34SW7AB+zsqGzTzDPTBXmhl7H3rDJ5IsadQ5jaunOO8ccqnFbXTCbEdgHZrEVV5Mnrw
         9ZHA==
X-Forwarded-Encrypted: i=1; AKwUvBwbm/xDVibnZAW0AVJ+cGpw3kfGoGZlVHhywCBp31+frmJXeF6VO0pjXFh0nO8ecOYduTeEKIcf0t6IkQSrMg==@vger.kernel.org
X-Gm-Message-State: AFuF++lEmkk3GT2rLRmyI6NBGljoc1JFuK1UFHODmIxPiDiCmAtRqA7g
	hqJ6WpmC4JlLpueboXpIzkTpv+IDEc82wClPslFtCpnwtZPx0ACYCH3u
X-Gm-Gg: AYBFou31MvGRBPbfYlhNL5ZJP6LXUqsAMmLhsp3LoxvbhXXIenkWSEP8iFxvfSbkqud
	TDlHJNSV///IWNFur8OmOxcEObnGqTqeCmHDR43Gp1TkXoTt1J2niK7YQ6vbe243S/C3GAS1iLq
	nWNovZILqGqunrPIh8Kzgw032dutihKOdDcwCEqHznkPEiSRD3En7EZ09RecmifAOIxX1vxMDHC
	s2nE7MjAHymGJY/sjlOeshhgYTSlFPN4vOWzAbTMaDTr1A06iOZ30Bb0sJ8Ul2hpL+TO/TB1bnQ
	0p+Ol9Z5jYSmGI2+xnOHtT6NBjZXEY7Laz20OJsGJ4pyE7viypHv6ttoUEbVK/3GSkt0jI5/nze
	n8MjEcPIqm2xedKSJ+jRxWQHn7UxAcxnnetvGKwqscLYRoUbjg23ARUYxg+M+kAkVRCQ7gsUkHX
	nGrA66orbVVcvPOqlZnJn6YeiNyTiwh8TZfyvVROYnAcVon1jBD76qLOLK+ir+QsuMXOJzVuPit
	sAAKZF374/0
X-Received: by 2002:a17:90b:1c0a:b0:396:41d1:cbc7 with SMTP id 98e67ed59e1d1-39b2614e099mr53418423a91.3.1788989093027;
        Wed, 09 Sep 2026 14:24:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d7e9014cbsm6506a91.16.2026.09.09.14.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 14:24:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 9 Sep 2026 14:24:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Cc: linux-mediatek@lists.infradead.org,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 1/8] watchdog: mediatek: Add wdt/toprgu resets for
 mt6589
Message-ID: <b01b65d3-9ff5-4bfb-9917-5ab287535078@roeck-us.net>
References: <20260908174259.9009-1-l.scorcia@gmail.com>
 <20260908174259.9009-2-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908174259.9009-2-l.scorcia@gmail.com>

On Tue, Sep 08, 2026 at 07:38:28PM +0200, Luca Leonardo Scorcia wrote:
> According to Android sources, mt6589 has 12 reset bits in the
> WDT_SWSYSRST register. Populate toprgu_sw_rst_num to allow toprgu resets
> in device trees of the many compatible devices.
> 
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>

Applied.

Thanks,
Guenter

Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2701D331EC0
	for <linux-watchdog@vger.kernel.org>; Mon, 10 Aug 2026 04:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786336488; cv=none; b=MlmWJRx2HuSa8vQ3DC3SMUr1Cfp9DcjjmKCUHdRYHc8H7Yaw6rm9gL9AOjz0mRU5vSU0c+4C58o3F7pxCfxCRs4XVRbQTCjh3Fl7apwuhNIGvG2iR4b+yPEMapmz9mscf5IRezHCzI7feSjJZA2qH6vQPGtB+IIIw7J1dxQcHMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786336488; c=relaxed/simple;
	bh=ymf6y+9WLMdu/6Lp/NMkAcayGa6F1B5Eq5ptSGFLOL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLgTItsR77H/gUsjwwqRT/eTbZlfcSiQPaImdZdGoKlME3V9vuk0oXm5smtn3e70OKb2HPUlhg30YnZZYQcQh5F9hXfyo4BJ33RhSMdqRrAfLZlMoqT+CZx2or4a0pWkzJXG4sDrggVpMeLDNOuGUW3z8EppkhPRwo5KPWjVh+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXD7/PR7; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXD7/PR7"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cfff5f88dbso22619695ad.3
        for <linux-watchdog@vger.kernel.org>; Sun, 09 Aug 2026 21:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786336486; x=1786941286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=d+3HW+UbDinwr8l0lTIom8vJ4+7ShLxx8WvyQiMaSHk=;
        b=AXD7/PR7+DWs83Vp4HCoDcNKoa4GtvK9vivXxWfI05X6wGMAgKHa++IqRxyIv4+5V5
         U75T0IlbkaudoN0e6yLmS+Ec/MuLikXNs/OB49z0nGWuxJC4aI+9PKss6tYaD8ldoWyl
         UIfN12SIMlOtztq9EXhQwE1S7walfMF/RBfPJvxYIj9okkz0yGuLLHqtK2Xl5LJvYC4H
         N7pmIv4rRsy7b7hIXqgm93hIYnFdi275QX/+8Zur6Xs7LG6XtUSRIvGw4y7o4xNsXKvi
         whh7G9MvEdWdsJC/kXbNC2scBJN2L/Ud2NmZVdI+ZCK2sri+8UzrB2zkTr3t2HfAk2RU
         VDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786336486; x=1786941286;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d+3HW+UbDinwr8l0lTIom8vJ4+7ShLxx8WvyQiMaSHk=;
        b=pXWazD1r1a0Ak/m3XQSR86tSqd5JFaDrr7tM/fDYwFBZewFzsNJhqt5B7wI0JguaUq
         xJnN4hcGgmJW3lClUfvfqmsPuNNYSL0QaZmfYjQ4nXPuMgJliDar4GXXGgzqiJfX01Ny
         5KUQ82/xL2HUOyXt8b8k4FaBRGxGzr5mFL06iMyKnxmHBDDVeS7rkSQhwViXlFsYYNdO
         kMECyI+53QStyxPVeznQRUrsm3VB7dTjX27LBRjO/gtgMIOY2ZGnbyqDDrgJBLMqnlCu
         W353AiecZxIcaIXUD+QxgckBuCYwC3tbHfc6nhS3QT35eDf6zcekNH8U6rKmNOeYglRB
         e0Ww==
X-Forwarded-Encrypted: i=1; AHgh+Rq2w29acaGFvieAQKZvo7IiPHdxksUk6YPzATIAPhawP9Q0s8N32kTotOTp3iB5IWJGhtLPdc8Gh8YI7NL0Zg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVxWJvpoVYrpZYnxoPzhk8DgCT/Rr74d/nkJQerAvRy2dFmZqu
	jUHAsc3A7BLlDpNl9g+UoldsHwES+XRJuMY/JcSYqOU4wOGw5ihJLpJg
X-Gm-Gg: AR+sD10EBkTWS5v/LmppaqvGu3JcHQyOtu1XoYEaLXlWp/BavBOytDjh2zyzZnPQCVN
	DAhD2fLgQCkzwcc80DcvPieAg1TuZhO4UZFkCbC/IQxEGcvVNvn4gjgwpaB4D8kknfjQJV+VD1m
	rbPYZNX3FivpqZy19LQSU5ayRy9Ls3p7PYgyTca+56UTX+4125p6lbFE8Ct1hN9P5JZ/kHUZklS
	csiy2dGtOAn+Kj3o7lf7I2ItAi1S+URLzj+hPI8szJbrjUCU2YWS1vsJgYfAN+RoRNZxg3tWgoY
	oRm/ggbG1f8GZc52ApoGrau3W3I/7lriG2El3c2XahGVoN0gAyZKmSpJQaPLHoTg6E2TqUCczJU
	+k8WAmFUDojiJNMili7YPNlEDkULAhnwBoFaEDzoPOBATXkUJx0cnNPs2u4P5kMps+1B/k9Kzey
	lnaQ2jq4qPkJ3XFz72fRUfvWj4tLozeIGG21SGDp5xU4itmoGUSodMUbXwPMMB+q6TsNWlcrWtk
	Y4vKPj5vATj
X-Received: by 2002:a17:903:ac4:b0:2cf:a1c0:d4ca with SMTP id d9443c01a7336-2d0ca961ad6mr521823535ad.22.1786336486542;
        Sun, 09 Aug 2026 21:34:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c502bbdsm28714455ad.81.2026.08.09.21.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 21:34:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 9 Aug 2026 21:34:44 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: phucduc.bui@gmail.com
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] watchdog: aspeed: Propagate errors from optional IRQ
 lookup
Message-ID: <443b829d-67f1-4af0-9e07-021e1592bb0e@roeck-us.net>
References: <20260807081652.38692-1-phucduc.bui@gmail.com>
 <20260807081652.38692-4-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807081652.38692-4-phucduc.bui@gmail.com>

On Fri, Aug 07, 2026 at 03:16:52PM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> platform_get_irq_optional() returns a positive IRQ number on success or
> a negative error code on failure. For an optional IRQ, -ENXIO indicates
> that no IRQ is available, while other errors should be propagated.
> 
> Propagate errors such as -EPROBE_DEFER and -EINVAL instead of continuing
> probe without the IRQ.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>

Applied.

Thanks,
Guenter

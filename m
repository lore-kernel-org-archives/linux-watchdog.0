Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799BA396B98
	for <linux-watchdog@vger.kernel.org>; Wed,  9 Sep 2026 20:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986829; cv=none; b=DP/q/+dvZpELgi8nofieGMrAY2Z4N1pdq1t7EceOHSuj1t/3MNiKq3RJB4IealHr444lr6bT1E0G7bHDN4f4PdJNa5GhN1N77n/+FrCrGd7uk5S7dskQZ0uxJQailh+/pjaVCbjN6Bp9ze8/bsS8N0HdrJKXaVK+tRqSr6nBw2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986829; c=relaxed/simple;
	bh=qvRiWt5c2pR02hAjYA1D3/lp/tkyWi1Ndcm6jnLH1Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CPlSjkxQcOzYmoP7ZNJXuyf5jLpZ+qhxuY5MM0BgUEgXUZ2NabObXewtkMUkFFKySxlhN57oRMCkXIp/5IIA48sRFsEEFTpXZBaq4Qf7Cn0P1F4GtN9IkaGmMmfY7TqLcgkT5dHW26YiSFg8P0HeCtq2fxC4r1OapTjbZATaPw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6EhK2YE; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6EhK2YE"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so5331317a91.0
        for <linux-watchdog@vger.kernel.org>; Wed, 09 Sep 2026 13:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788986812; x=1789591612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+pVpYIqXSgR+sbP5ifOxjba32i7axh0MwsGHd9mcNYo=;
        b=m6EhK2YEEfaq9Q5Ha/DlD6EbQjISrY4jo7VXgtsmIuFPlSzYcoaOoaP3g8HIcrxqer
         si75WIcr1DxUfRLwowC9WVVjWX80v9IMfLiqxDbZBtKTlF1eJm/hh9WPzVQ1JTaWpNQf
         /qHT84h7lvi2dtJSJCIwfO+tLE6LdxbJBZge5NVWAmEPERSUAsPnozGoWfvrTODYsl7F
         12NxT8aJkSoeHEehtgEgwmN0rEdop3FuGi06ED7YqVNKLmlmGzoT4A7ViWBtTLy/MKHu
         mnKDySYvbexdl1C1slj4LBGF1sdcLMkeR9vqQOmWodUYopojrM28qNTZNEMIUoGvgcbC
         qf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788986812; x=1789591612;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+pVpYIqXSgR+sbP5ifOxjba32i7axh0MwsGHd9mcNYo=;
        b=p3pP3FBEwA9RAxHHau0+ah34qAWaR62falpdSG0mutkhBw3Nlj2kGEeOuKO0dAUoXw
         4i+lVZxQ2oiaG5Ujir0EYN0P1MCP/O+uwXXrXu4upUXySaTyZTwrPzbS0m8jMqKTJM2U
         F2VgIPQXLjqwmtN6AMg1wBfKU4e5wUXtMrb2gHeUl1WzC4TJPP2vEKYQSYpVfRD9UR3a
         JV8oeUDpmmEcWbmW0OlrGL1X2Kt8E9YcWgfG2QOjjDgH16UD9XpYjYssBuPx2ZbZ+vgZ
         ck9VtLy9DIfwFR8FQIK4e9is1XOX4UzoJ9e/XJdhU3BoZSrnUJoNW/VzfMph0by4BGVA
         llDA==
X-Forwarded-Encrypted: i=1; AKwUvBz4SgEXHNMNsNTHbkXzzzw39Qy+NkaAmNi8wHqL1++vlVO0tQrLKy/QCYgXMxo1fsjorLJ8VLPZbnb5J5FCsw==@vger.kernel.org
X-Gm-Message-State: AFuF++mzUcbrPNCPEZHImoE2n/xrgxu9891Ak8vagbUbdCjVhagfzn0x
	AotvNzp4JDo47OA3QcDA1fO+06Fodu6lwEX8jTpTzHF6M2RUQtmg80X9
X-Gm-Gg: AYBFou27UcmTmu/ZSyixpABQZn9NAJ6+FxhqWuCJdT/Z7wvcspxO7+O3Hp/JBF5oQKj
	Mx4rQIDX/lKzqKIySfXGhGSwJs8pmo7HTZO97Fi+0yhcqeoUaVny0b7Qd4p5jj5GlPxYgECCT8S
	cBJ8M/lopqxdTClTzRsxU7yvp0YD+rBNOtI/dnJhIvgpvW1eVQ0ydqbUeJbvWWDSUgEAJjSb+uL
	/i5U5b21D8f63k4+bwVI2djM2Mwo+/fLKDFTy5xS6YZRH1iQeO43lg07CoTqgpoylqU8PEU2Ml7
	/FkvLU/McdwX4Et5cq7/EIjeBDz+R5w1QiMx8iUxnOU/UjOctKVzBCnZgmtBwGsnCOGAX++XHPG
	SdaaK75XcusIiVp9vnCD+YIvlC2JKjd1XAPHCSzMebqcAyfbt2BcTwVDT+zsiuTTTF3Rl05WcVn
	d1OlK866+M5ehgJtvBq6vQ+as4gd1PgZxICUj+soPfZxncNGzJl8wVUwQ9ubIMdW5iXdIyc2G9S
	Yz81ictVrbM
X-Received: by 2002:a17:90b:2b4e:b0:398:9be9:ab8f with SMTP id 98e67ed59e1d1-39b2622b9ecmr55550499a91.20.1788986812401;
        Wed, 09 Sep 2026 13:46:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d775c02b4sm1227247a91.14.2026.09.09.13.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 13:46:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 9 Sep 2026 13:46:51 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/2] watchdog: fix repeated words in comments
Message-ID: <9e0336c0-26cb-4ff0-a1a1-b838896130c7@roeck-us.net>
References: <20260904113744.19872-1-hemanth.selam@gmail.com>
 <20260904113744.19872-3-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904113744.19872-3-hemanth.selam@gmail.com>

On Fri, Sep 04, 2026 at 05:07:41PM +0530, Hemanth Selam wrote:
> Drop words accidentally written twice, reported by checkpatch.pl as a
> possible repeated word.  Only touches comments, no code changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Applied.

Thanks,
Guenter

Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EC737CD5A
	for <linux-watchdog@vger.kernel.org>; Mon, 31 Aug 2026 18:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788202038; cv=none; b=iXn4CceHvc1HkGfIrFV8fJKdMykhHUNLm4vqMxBIkLFsaK5ZkFqwtwKB9lIlXT5ElIqy/DLsqKuC4WEdTmuull0zbMceNpqAz4nKsVFdxBj8DyLN1olpFLs1RtG6GA9pxoArUhgFERkmd/JLabWEOSIDNTCbyjyL1IGhgQuH+aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788202038; c=relaxed/simple;
	bh=eFVJqFjYCH3QC3ars0bbJAzWOw1C3Sqfnl6vgAE0qJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIG5pTxKqKWzqfEeIoy3jH/LcK5/+ZkNNmF83sPgQ4Xep8UV/1SC8azqaCgBWTEaxLiViZvsX0rWqvPiziPLt5d+lw/+wldYSHOmji3ZgVV6wNwHDejtS+F1eIUJyK2BwwlvVuZJjf9XbKD0GWHs0Wo8/Kn3laDlr4cTPJapBsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFv5mSFl; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFv5mSFl"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d6d28aa26cso27212015ad.2
        for <linux-watchdog@vger.kernel.org>; Mon, 31 Aug 2026 11:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788202036; x=1788806836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MlGtvQtKgpmUi5+9i9242pcEQrNhHwznKt4hL0QuTVc=;
        b=VFv5mSFlAhoGcimmB4/cv/LnCPZ1kvy5K8cu/kmcAyd6V6qwxa3ouipivRHa5IB3E1
         qD5VBelDAuFkYKASGHREQCs6Aj5J6gmlcB/mCn6hnFvZErM5iCIOlVaTwU/zHzdO2HL0
         6pNl684bBEYkkbqtMCKbTUQnjgz8LVxU7D061ENYWtu5WcYicSzsRcCXtn93jnkPoflC
         VTVW8uR+Y5oBj7v1E6E2SzKEcYKih7oayEHiyLpTEWq1IBd25F0KIzEQE+huIgIEMQfn
         MpV4Xty4zQfhF7qNlZdGwgQHhogxO0SW2zQxbuFXmHHX2QnnYYkikN6LiKBOa8hbKDr7
         uyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788202036; x=1788806836;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MlGtvQtKgpmUi5+9i9242pcEQrNhHwznKt4hL0QuTVc=;
        b=RZSvkY3KroQjOxbvIxUYeBClkANDMNTF8j0+mp8+d8GAe9a9A6ry0QeZpYQQIfzHmC
         +XnvQxTcUQ4vbb4RjEjU9tC3ct1ivWksFFi4R/u+H0B4xs3FxfWY+KhlEEKYqlcz0azB
         Pmbn5ZR31Sy41PFAmTJH2MPP4RU/aYlTmYU3Qvf22aANtJSuXTMn4KpNBvCTNggjLVus
         7qsJdKgUW8Dt2SVlFk5V189Z72Bnk1YLv1Mdcd4+2jBzCO8HYaJhbr6Er4Ryksi7X8WU
         OuNqXXcYwZZnd50pxyp9XGaVxmQQwzT/CH1i058xKTm1pm5Y+dekUQ2xKDA0X0iwFp8S
         lKkw==
X-Forwarded-Encrypted: i=1; AKwUvBzL7fDJH9wCadEXk8XZ+ml0TTUtNnGfKgK4eTOb5o5zLbLxVhfiesPXn2ZPkiTnMWD+GObVpWQUy7w/18QIDw==@vger.kernel.org
X-Gm-Message-State: AFuF++mHOBhX0/U5lMzXNotuoJ9H+0KwPvpBxumKm0pQEIGoT0uN8LI9
	ZTwvnuT4cowg9KFYU04yokA3+1kv29bs/QPjsaNVKGueiKZUvxc5rzs8
X-Gm-Gg: AYBFou2ien1gS7KCzPqppD1JtL0HuyJHcsxTTeYn6Cr5tyiEX98aF6eg35E+LMC+Gwg
	nZVWqvLzjA0T6TIQxSFQOI8BSxjpiXPAkuaqsSrvNz7gpfS8vTNGui7hj5DPTp256MPJdEYDDjD
	HdY47dvnECohTDw7GQjN4ZiVVVehnM9Z4retehD2cYxHNn67bG1NRFGs6AJ6q9612k7sXkXgRRI
	S31eEz0DTTbGadWDzNk65Z6Y3fxCI5b1HN+cMMKEkRIBoMw+1Ztm/2Wnw6YXFpksqf4KX5AFR6Q
	Tz1t1vlznThMEcahDutCrwMQRYvQ4WwUEuZl0q35RxnX2Tul+cDdGiSSRVxWRpfKR0p+orkvGyX
	BVlT5KrTmPH08ZGVhGlnsfRQ2hcJMOWn/Vz8JAke46+y7QD9BVTF1J5TLkA38M9LC+I1VCXTFXL
	gSYruJCt/og8jTxvMo6G8epkBvC0oNGwg0ymdkG75+5bIMVFWECA3OHpT1sCikGY5PILoyd/88M
	w==
X-Received: by 2002:a17:903:1b0e:b0:2d3:78c2:1f19 with SMTP id d9443c01a7336-2d74ddc6da3mr455182625ad.9.1788202036193;
        Mon, 31 Aug 2026 11:47:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32b5bef7683sm17555601eec.12.2026.08.31.11.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 11:47:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 31 Aug 2026 11:47:14 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Antonio Borneo <antonio.borneo@foss.st.com>
Cc: linux-kernel@vger.kernel.org, Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] MAINTAINERS: Update URI for watchdog tree
Message-ID: <c2e2247d-9bf9-4a8f-83c9-2bcad1896979@roeck-us.net>
References: <20260831153646.396038-1-antonio.borneo@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831153646.396038-1-antonio.borneo@foss.st.com>

On Mon, Aug 31, 2026 at 05:36:46PM +0200, Antonio Borneo wrote:
> The old git repository
> 	git://www.linux-watchdog.org/linux-watchdog.git
> is not accessible anymore, while the development of the watchdog
> framework is currently handled in git.kernel.org by Guenter's
> linux-staging repository.
> 
> Update the URI.
> 
> Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>

Applied.

Thanks,
Guenter

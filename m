Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E24E426EDF
	for <linux-watchdog@vger.kernel.org>; Tue,  5 May 2026 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777986728; cv=none; b=fzNXaoto1pP5MRbsq+VtUy/XurtR2ONs7zTGh0prgrmHyY1QuQkwUvZlmbT3YUBPgETT4hmPAskH4dgG6VVRUn6DTTcDgk2qS+0dYzj1gZPJufETNH0yr8qistfhsmAmrXHtZxN4ogDlyfA2pUOog3WukiSKoWvGgwJsIxKpIig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777986728; c=relaxed/simple;
	bh=/iGBjA/S0S+U8nYvRPVWTfXSFZOo3x77SRoOfbcnGLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lk51qANQWK45agzt3jCHHZTQLR2DjWgX2OHEA7JZN4Fl/zGtIlL8nQcxRKHeOHfsxbW0jG8RgQKOPf75QHedGgKKaqq4y+1ODjB0UDvJoiT3/5Q9LD9mAj0x5ryKqNpdq1amXLTijU3UkNZYJhBPIY4p+vUyiyeu2aAclWW2gBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWYAC9r4; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWYAC9r4"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2c15849aa2cso7018020eec.0
        for <linux-watchdog@vger.kernel.org>; Tue, 05 May 2026 06:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777986726; x=1778591526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XN8oRMobbZpb1CameJAbz8F1xiPwehhjjhOCQAZYXaM=;
        b=VWYAC9r4uoyytsgGjbWwdQnyAR9RxST2wPWpgdYAU+QeoOEyPjRobEwr8x+0Wi8O4k
         VooGx/2XPrhmM2gCBU2qOcHL8pUpeAnJoSF5magq7kxsO6ZrIhVAw/4uDaqvhqLXASwi
         KiOzFzhp4vXZwReJEoQwoWS5iytx3vw8U7wzJkew4YcrIKKoavT+llVc3VWdJc7twC0X
         VHyM37g6rc2UKspfCxkryC+k0fG6R//Xwr60zetIF3IqRaLIOiPd/Oi/tmpAawcX/mC2
         zsIZPjnXpICsCkyQ/1D/DQwnU78OfAWC8pRDRR/hY/1ZNAE3/v8iMYr0gdhtDt0W3uJn
         tdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777986726; x=1778591526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XN8oRMobbZpb1CameJAbz8F1xiPwehhjjhOCQAZYXaM=;
        b=qArl/cjWb4v7AL/JDFEgkCccXiokNJFUsUpZgunv2q/FhAO+el7vPGklnML/3UUCBA
         BxpRHmKFS/0qfS936V4PbyB3DPcH3SXcZm/NiJi9Cmn7MmRTwgCkp1eIGGTpD7NHu6x6
         uQpvh4A06H9eIy2lI/n6OJiZdsbd9aGGuE+XlS33VS6h0YE7AKirD2wKOEIVWu43yRNr
         VlwQAvGqGFqHXxhBp83ALFSLuN24DHIAOFcNbcjHxBx03HsApxhHTlsYERTPzpSmqsAe
         wGD4ryKvnNLVrAmkre0r1su8sMix2sl67MfCKTOeHUI0fwAauReZ0LhTDJDzK8sW1Z/1
         /5zg==
X-Forwarded-Encrypted: i=1; AFNElJ/9WPGv340hWlCw+cHD0lgOjr/hxJSjkPPudFW1GsCeBYC6pqspQ8lUoL/HrMmzAAqyc6lpaKw7OXqnOT08Mg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzO+jRkWYf6sCI6OAR2uJ2gci+cnc8mTjDcMchYZGVB3ueq1xct
	d0P+hvoTCW/iEgDyzt/8f9VMepYaRQbw2tQquMImwdNO90mg388leQsA
X-Gm-Gg: AeBDietTWhahh0t1LJlRY7X6VhpYmVt8bmAqCaUmUAkbhr56sxzuBWRmaI1wHgYGUGH
	IFo3PhGMgs9dcyRry/cUwTb/bbPp10Thx6uKofPD2uz3PyV81Vmu7wElhAMODjJUssDMWJ0e8+I
	2oVo8TTRjOkBJrEV7DX0E9V1yoHNV7Hv4mtMEzVZ8+oyrgYRj/Wn1seSSLxFFoaHbyLSOFw7Tc2
	Z6GUlaB0TyksYByefj6u3FE/Oyri3RRobxvZbBly/q2nJiKR0ZvzeGveseU2YiDZdBoSweX4ZXw
	xdj/l+//r91efusuDr6Yyy6XIbVS4CjiGBkZPXg0nP3hiNEPuadEOE0l7fkE8+S+lRnM2J9e7zF
	mTvMZlZ3CdBDCwQLx9LrT/N1LBQXtQfPTG6JYp9W/eMvOBXflhp8tnGDsbz4mPqzo9BjWoOk3xo
	SaC0Aw0+it6AZl+1YwRb7SbQfdQuE+OA3tpwvfZVvT40pQ9NN2q9xk7TfdPw==
X-Received: by 2002:a05:7300:c86:b0:2e2:9c65:ef6c with SMTP id 5a478bee46e88-2f407856797mr1528228eec.4.1777986726081;
        Tue, 05 May 2026 06:12:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38d78391sm27034367eec.7.2026.05.05.06.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:12:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 5 May 2026 06:12:05 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Philipp Hahn <p.hahn@avm.de>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Philipp Hahn <phahn-oss@avm.de>, linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] watchdog: Prefix WDT with ICS for clarity
Message-ID: <5431bc4f-4515-46c1-b121-931b798f951d@roeck-us.net>
References: <cover.1777972790.git.phahn-oss@avm.de>
 <5a71979d8e8ab8e0a30de33f6aa2540b3b5dc1ee.1777972790.git.phahn-oss@avm.de>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a71979d8e8ab8e0a30de33f6aa2540b3b5dc1ee.1777972790.git.phahn-oss@avm.de>

On Tue, May 05, 2026 at 11:26:16AM +0200, Philipp Hahn wrote:
> From: Philipp Hahn <phahn-oss@avm.de>
> 
> `wdt.rst` is only about the Watchdog from "Industrial Computer Source"
> (ICS). Change the title and rename the file to better express this.
> 
> Add missing SPDX license identifier `GPL-2.0-or-later` same as code to
> silence `checkpatch`.
> 
> Fix wrong link to sample driver in drivers/watchdog/smsc37b787_wdt.c.
> 
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Applied to my watchdog-next branch.

Thanks,
Guenter

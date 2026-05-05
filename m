Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C8F477992
	for <linux-watchdog@vger.kernel.org>; Tue,  5 May 2026 13:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777986674; cv=none; b=WatVKsJWa38QmeINNrWL+S+Rqhl8/bwT2KoVCfa3AdGsvyjT7kVlrAvtBJJZDeuQDlf0p4Z0xw2/9FPHsJu+zXBbG0MgHmen1CFOM67ot7H0jamrx5QEWRM8z+wGrdZ3KNhqOq00bqmBoilwRC3eEWLvYrUqqARZW6OhPkoyJT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777986674; c=relaxed/simple;
	bh=aDkjiAgjC1tB06M+E3a8vQxAEb7sGjtBon/0/A7o9Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZNmUlbVO/I9DkWhPpQ4GpfQ1GAQPnt22UJQ/0/rQLjZc6NBAxBSR7Ct1FT1bda7pxdMWKd22jXid2KnX+XipBhH6Es18OqR35mfqE4WgzZYuBi93AcCApIgf0PXby2v/PVuQplNl9HHYNz8ShnszWvNuS3U/r+B4I8QuQ1LN/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iR7qgDC4; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iR7qgDC4"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ee990e8597so5238726eec.1
        for <linux-watchdog@vger.kernel.org>; Tue, 05 May 2026 06:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777986672; x=1778591472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e3ALUZ/czN6amkQ30G5HPUMrNnDCq1VL6As5DCz6Ts4=;
        b=iR7qgDC4As0YjylGJt5kxXm0LH0LUiXWjADZyu98af/bmk3qytI07xLj0iu3ftWSjf
         ubWSijbklrOAXGgCHuctI/n7+IqcPAo+hdCqoQ4QNYeCZfzPpNi5m2Idr+wPhGsTbCch
         dF48BlF7k7LPIRoBm+ZK5vssk9efoifamXkWrUmUcGo5fK9DYFP4wv2ekh3WGoti6NVL
         HExZTy2CtaYHExSXmdRYql0HDMnUm0uY2lo1rt245HHFbb4hZ5QsfvQMHGOdP73o+8Ep
         AWYG8yrq/mwBL4DKg56AOUiX3DO1mqm3OS1I/H8iFtLrWI1yNheQTBq1uEO8ZMwdPWB/
         baZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777986672; x=1778591472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e3ALUZ/czN6amkQ30G5HPUMrNnDCq1VL6As5DCz6Ts4=;
        b=dNbDd9D67KTyA7lJT5cpnRjhAuCyOmz1e5vhjC4N2lvKCjtG6bISiHY00bWC2hL165
         8EWPNHbFw6CwysPNrjMK50exlel2MWnZmtfeEEt/62DlrCJLuwXaQGPNbqjcmAMeY+NZ
         f8Jpa2Aqsw4c1e+4kf9y80vgYqT90c5LLtG8XBiz5+hyaLkwkG5b9qXH7cl1EmsLM4df
         DnGWOAqs2rMhaWPhW+3d0iy3jTvhUJtRJf7prAGWoy9xJNlVeIa2OTVfarAuWR/tKCxn
         m+aGqgZrnS/smTcamFvWRR98KbxML3Kshsaa4VuYcRDk4cepGB5NTqYc7+vRPjnHnymS
         FUbg==
X-Forwarded-Encrypted: i=1; AFNElJ/BLV1irsb1lRnM/975Yb+TI8G31W5r66bycJQkJVBPK0QghsY8obKcFgDQVzrdF4C7n1oUr2Z1uTeDJVBdfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbB9XvA+oRZfoibr+hD3ptEG6xoEveqiMoiO8HB9TB7O/SBY9L
	onxukMsa5t4m1spC2K/90TLyaC230OCufxbcex+tiyAl/97bBxuGSR+/
X-Gm-Gg: AeBDievRQSOl4mGlTvUwcV4994JqSOO5L3Dk+PU1yqdHam2Lx1uYbHqwq+0B0OmNr5e
	0Ggw0ifeTdvIIMmu4met/hlahryqIFy/kxblsLX9XFfTfq8u0hJ5Iy+FuGLERaRqrKjHR8JD+ph
	f+OVAf219AYRk2lyFU8fCi9BaB8v6WWhQKB7v4OwcjQwXtMxTahUfH1pIMVwsDtFI801HxaWM/0
	yviUnnM/zspTHy7/UrUsF5k7ewFMk4cq2rezSp6gVafKrJzKp3kOHX0+VQ7y3dXBUoUf+Sh3SVu
	U3woBRhg+GEc3yPJzyTjKVJUVbdETWWN3uCVO60NuY81J7sDfVX/7gD8xIG5vJmrhb2/emyUonV
	PVBoOkq9u5xUle+iu1ZbR++UFD88unyOXWl+weVtGZHRdPkQpqLKIvryaodAfLiNnBRQZmrtCol
	TwNn5kH7j05C6vNTtp7jItEXkeap1nbpc91++M0wYCPFBuuAg=
X-Received: by 2002:a05:7300:6c9e:b0:2ed:e15:c923 with SMTP id 5a478bee46e88-2f409e9a9e8mr1339042eec.31.1777986672291;
        Tue, 05 May 2026 06:11:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3889d611sm26652407eec.1.2026.05.05.06.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 06:11:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 5 May 2026 06:11:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Philipp Hahn <p.hahn@avm.de>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Philipp Hahn <phahn-oss@avm.de>, linux-watchdog@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] watchdog: Separate kind of documentation
Message-ID: <5236855c-2142-470c-b112-4d12e58727e1@roeck-us.net>
References: <cover.1777972790.git.phahn-oss@avm.de>
 <7d1b722205bab83603832e66750f7b5f1f73eaa5.1777972790.git.phahn-oss@avm.de>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d1b722205bab83603832e66750f7b5f1f73eaa5.1777972790.git.phahn-oss@avm.de>

On Tue, May 05, 2026 at 11:26:15AM +0200, Philipp Hahn wrote:
> From: Philipp Hahn <phahn-oss@avm.de>
> 
> Currently there are several (sub-)documents for "Generic kernel
> infrastructure API" and several "driver specific" documents. Put each
> one into its own sub-section.
> 
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Applied to my watchdog-next branch

Thanks,
Guenter

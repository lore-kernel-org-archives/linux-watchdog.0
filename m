Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8467322B7D
	for <linux-watchdog@vger.kernel.org>; Thu, 16 Apr 2026 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776363026; cv=none; b=p/LnADcMMlQkzYPzIVw8mMmyGyLPoutXdRyrSM8QNeaYqHP3Fb/jR7/JUDeu2JG5lpgVdxONQR7qc2NU306w+Emv03YGRbgWgeg9u3f80QC3PT/KHoPQejbWrWRfD8judNuHnkmOYybwUxHeOXkw10KVngydWW9OTDMxaOp1S0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776363026; c=relaxed/simple;
	bh=LNEmRj4GM7QZRskLbZ7jxQJLo+Ld8PY96fFTTIL6Pqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ensmXUxuITIwjKRSybt+AzgJw1SbF4lycKrekpxM7hzwL+B556fj3Eb0KEGbT3F8HoiFRjNWSuN9sZ5VUGTAEYW+Z3DSN+uKB5yoFo76PWlX9FOv+SATlnFKC7eIjY0OAZQTriF0Xg2H3CPfDPojgwnpnGMMgwJGnueuAAXrCz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkiSTBDc; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkiSTBDc"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2d9916deb14so7449870eec.0
        for <linux-watchdog@vger.kernel.org>; Thu, 16 Apr 2026 11:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776363025; x=1776967825; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3hDKqXq0TQOD+WF48xNISptvbPmS2Bcedji2Qudo7Ew=;
        b=DkiSTBDctKbODSfxihFtB8+tTQUmrrVqBj31+09wvyFwOt2yq363JDKWLQPa6mYxi/
         wl6C5i4eIk5BIt7GcOG9lzxbW/IYqJFGvz8KpBzThn1QiJJ0pQkKuCSWIn657F5wc7Th
         moJVUi7w6CTHcmTLupdiXZsv+EhFaS3fzC1lCTAZXY5/xgliO0sPGGnEFGFEhX+LsmO9
         fELNMk1pGclv3cxEI8m4jmIXBbYgedZRIXIMTec1CfmfUcw2KQ9eUEm1KfwUJJ7dpH30
         24L7puUq7614VKKi/HdmuQkCtYs/2M/DPcacCnuNIoM4TNezbiHHOIGJHst0YMoumI7O
         d6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776363025; x=1776967825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3hDKqXq0TQOD+WF48xNISptvbPmS2Bcedji2Qudo7Ew=;
        b=IcTO/Ni80mrUVM/PXZ4jmwz6JObdzD459Pu2cmK4/ORVDMuAMzEVn40g5CUIMM92Ii
         cRKpbB+zd3YC5dli8lH+V+vva6iaret7eZzdQcPt2c4IkHZ1wv84x8phm4sI6DhEPYEF
         ShnmGGjJ//unoCTwKzh5r+1XnrmwF2scmGzI2sumAiXkOMiFprPc2lGq3Ch4PJKFIf+M
         sQMZirgyLpb9G4oWNoZ4Kd9oqBae9t8+f0Oy1N/4jUVZHh9EGxEYa+uWETxc7pLCU1DD
         Xj0EIrNIbG2qp2vTgZ6ME1RhnfKwmeS34DifUI4P6hHaSYKG9/otqjLm5I0Kww+ogGtp
         QcLw==
X-Forwarded-Encrypted: i=1; AFNElJ+KwV0Kydi0tDUrJaSbrrBjsspr3BERW7SRU9dl+UTJrXZJ3kJ5VBErIkHxohZs5ZLZrD1Xwyc8VjOM2BVT3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPeV3oWmHv9vsJAvQOd13Ji+dmeouDJ+XKiz5t1MTPYWLdBEsQ
	qZbPbN1A0Ua2zDN9SkquJmjHYekTB91jthwAMA2WatEGheZRXamQhgp3
X-Gm-Gg: AeBDievrUy/iRMgHTIzHervh7ycNOJfSOWIUV91cLR7SIGrsbcc3tt6RVDgGm16kjlk
	MsqGzi3HyuO+XL70V2wFIo+qAi++KjqE0S2Ib1qslYZHCG5tBfzezp3yrCDXE99pYhJNrQsWB0N
	Z7ZggzM5zgMoyy+KHSx4ecZNoLLxtXJPxEMAYoAHnZC4H9Fluqo8u36BXL/P+8TlGe2yNiqYAF5
	h+/DZwmCpIWRIPBb2ucy3+PWFAAOVC15yW3WFaJ3h5Wi/RAIg6EsbThrUxwDCfsxCOnNh2N5W3s
	EmZgS8XjSbWwci/YiPd/Umb+CA6KflpNurADm1LvJ7jNzJTusdaLEh+1DYj04RxOj6TWOrXs15U
	cu6dLmIjxlkJrBetqBkkVQN/rqGevrFzaVeYGqgwvSjLhpDEW1VQlgo7HTed80QaMyEPwCOHr9e
	KOEI88k0sF66FulslZhdtq+tEvAZ3PE0A6m6pL5K/wG91IKheYIxLxD7gYxg==
X-Received: by 2002:a05:7301:4092:b0:2d9:6373:ace9 with SMTP id 5a478bee46e88-2e2e435620dmr195810eec.8.1776363024659;
        Thu, 16 Apr 2026 11:10:24 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8c10a688sm11187688eec.4.2026.04.16.11.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 11:10:23 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 16 Apr 2026 11:10:22 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Steve Wahl <steve.wahl@hpe.com>
Cc: Craig Lamparter <craig.lamparter@hpe.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
	Kyle Meyer <kyle.meyer@hpe.com>, Keng-Yu Lin <keng-yu.lin@hpe.com>,
	Steve Collins <s.collins@hpe.com>
Subject: Re: [PATCH v2] watchdog/hpwdt: Refine hpwdt message for UV platform
Message-ID: <55bf0c0a-1218-4f1a-be40-0c203e91c4e4@roeck-us.net>
References: <20260318155005.90271-1-steve.wahl@hpe.com>
 <f7cc1132-390f-4f2a-8884-5e3d90b8be8c@roeck-us.net>
 <aeEMZyN94Hj6JWHo@swahl-home.5wahls.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeEMZyN94Hj6JWHo@swahl-home.5wahls.com>

On Thu, Apr 16, 2026 at 11:20:55AM -0500, Steve Wahl wrote:
> On Wed, Mar 18, 2026 at 10:42:09AM -0700, Guenter Roeck wrote:
> > On 3/18/26 08:50, Steve Wahl wrote:
> > > The watchdog hardware the hpwdt driver uses was added to the UV
> > > platform for UV_5, but the logging mentioned by this driver was not
> > > added to the BIOS.  When the watchdog fires, the printed message had
> > > the administrators and developers looking for non-existent log files,
> > > and confused about whether a watchdog actually tripped.
> > > 
> > > Change the message that prints on UV platforms so it doesn't send the
> > > user looking for non-existent logs.
> > > 
> > > To aid in any future debugging, include all 8 bits of the NMISTAT
> > > register in the output, not just the two bits being used to determine
> > > this was "mynmi".  And provide names to the bits in NMISTAT so the
> > > code is easier to understand.
> > > 
> > > Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> > 
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> Question: With Guenter's review, will this automatically follow some
> path into the kernel tree, or do I need to call more attention to it?
> 
Wim should pick it up.

Guenter

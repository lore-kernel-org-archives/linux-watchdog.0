Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792459650;
	b=s/IrPPeqEcXaPNK6yQUcewDfxcRa/wgOKSaAkMYWwQClqKw7dnsNA0rFEv1CRwmYazDW
	 2txBBGf7gndAIvMWclaZdckiizsYT7dOiLgQ7JPDdFirl/dLoL7VqsOs3NFGubLOIJ1hV
	 qb7gWoT1qRmOV/nwAGpUfz9xuKSuaCUNySWrFh60YCz15GfAPyjtTYM9BGlWSq+9An6Q5
	 sW/e1ihokiqk0ZGMMrJ8dctMsocc8UhWTp76/dWnhzswGGwBMmrdUl5xJCNhNeQmCWAag
	 0joeEDKiG1VgOOKnbZESxx3flccAOVzQn8einy3Oy+9zVqbxdj+4f8urVQYG/aD03Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792459650;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Hutm+uNJMffbjHn9uMi1YOHvbILCMJXO/l5lic+hljg=;
	b=MwrjK6cMSnyKisSZQbynOKhvzGSoe3QddawYgrTj8aptDbgBSbwmHqsH75AfUAgxq7g1
	 1ST0eP2VJ/IqVk8swednFIk64Fn94zMOwOcH/H/UVR89Dld6MLXfwpbyUDb2Avjk4+f+4
	 iSj5DNOnZ3D+nzl51ZkQ0szCCMzYWOaZQjfInzbSPAaygCtaUcOfSrGD98i3FO5jZYcdN
	 MCHdMOsQTyGBwdgXSTdXNyxWjKmOwBPEZPFJHe6+I7aVJecDnskAs308H8Cwnacg7gAF8
	 MSFZw0ebVhkDly4sjiiAW6odqcnuOR0MTpY+3V6LXIhLUmQe9NHHS2fRG6TIbsB2qng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=roeck-us.net;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XZfcHtyg;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC26606A31A
	for <linux-watchdog@vger.kernel.org>; Tue, 20 Oct 2026 01:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFC26606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XZfcHtyg
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-15354aa70e8so3019321c88.1
        for <linux-watchdog@vger.kernel.org>; Mon, 19 Oct 2026 18:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792459649; x=1793064449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Hutm+uNJMffbjHn9uMi1YOHvbILCMJXO/l5lic+hljg=;
        b=XZfcHtygFTwbNHQkMUuE1HfYBbAz4Ub9c+d6Eu0BAfutbD50i4iu6SfxQ8beSp/Idq
         DZojc+oXZ7oPlhdxNnY9EdR5OaWTIX/hQfE2VsfA6ng2ZGCbuGmSHp0Dymw0y/47tfdT
         TV/0ar1GwDTsH6Ky6eLZe+2tJ9XlaWFlQ1z0Rwo9Obdpz0bY9epiG1nGaeT+xtXzo+9W
         TU69GK3f2lwzrSpdVLpkc433U8Z7kUqbin1TiaAKNaltRQbwzr4yfiPVvYeplsG9bK4P
         JVk3kQsSoykvxAiUVZcxbrTO2/vjR8ekAwX3v0N6ELiBAo2baJvnEDVfmJVyqY9rvHUS
         weHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792459649; x=1793064449;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hutm+uNJMffbjHn9uMi1YOHvbILCMJXO/l5lic+hljg=;
        b=VO8C35e8exPfi+FhgICwA+9q+7IA+VXRgh3r8cU9PmjLp82a6QPU4PbHzlHIIigyEI
         aZu2vFstYDWSrSoZtgUGbokcd9oFPgfC+7c8i3/fDol1t0F02fBe0T6l7VFsdmg+kYmS
         nWl8FgoAo6rXAWnYMvrPA39Jav93h1+NZBwcEiKAT8+ITjRr4kU8jx2qNNl9fTmWLmYU
         NNMtwyugO+A77eNlsIHHOUp2V5L/OZq6fcmCrKgcqYdFwnv7LfMdv4SGlS64+HSqZn+7
         ZPQ6cP8Hf5yaYkAQOM75bPmdxWlGklKfwc6ypI5exHeVBKP6GPWY8S0mDkYoJjHO0ZjN
         8iRA==
X-Forwarded-Encrypted: i=1; AKwUvBy8o4pl+kjrCA6N/I1aVkCG/hYyeknn3KL4cR0cBQEdhqcLOAXHKo2m5P2/ZYkVGsBA5Ij5pbsjlOT4Uime1w==@vger.kernel.org
X-Gm-Message-State: AFq9FYIc8cH4XEhQahFqAiZTzlTRjmIlq6UEWvS72KE+yG3yDdxvzbVK
	ohP1KgY0hnsU4HGd9UrOsB4XWJoG7OFIh5zW6flVC1r7SM4AvLygIseG
X-Gm-Gg: AYBFou2dj32e+caA9Y7ydax8uqanz2QCAVJA5/qNDuVaIgOFGiIL5j63y1B/r2qAnQM
	sdY6SKHlOx1w6RdkoG8AMdnNKvELYGJhhNVX00XUE9hzULDvQn8CrUv2HbsELL4k702c5I/wP51
	8+xFE3ZOEjcL1Kr86cWd0p8JUw4wQB+wzZ3d4xrMIH8T8Q0C4K1zIRp/rkMFpjhe2klLoASRM3X
	JbFvP0XZcT07vqDwh+0AJBbUMNnOJ2XsjmgXrfu6KmVhgLXsahoqrNrtV82mypO6VO6lTEDUzFj
	H+KgcjY5yn4EgOUrmTHk6h1dg76HjbsVQE3E6LReXUgks3+4FFm2DBfqucuUjjGiOgvdenUuNxj
	K8FaId6db2ABRpMIOGKfodw76cPZqHeaiKMXZVZDVQl39op5MQW5uiJPkyec7lc0ZK8M1oSlspt
	jf6bCzg1x/mVNTcffQLgJCebPdt7g2qMxGaoM6IBY+BTg/QlhqX/OwpLRBC/NM19o2yuu6cSGmQ
	l0AvNNaheqD
X-Received: by 2002:a05:701b:450a:10b0:166:862b:9bcc with SMTP id a92af1059eb24-18512f1b124mr13440753c88.18.1792459648645;
        Mon, 19 Oct 2026 18:27:28 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831b75be5esm44095884c88.16.2026.10.19.18.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 18:27:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 19 Oct 2026 18:27:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Qiwen Gong <qiwen.neosys@isrc.iscas.ac.cn>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org, Zwane Mwaikambo <zwanem@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: sc1200wdt: add missing MODULE_DEVICE_TABLE()
Message-ID: <dc4a5cf4-c6b0-416f-9fb3-a89de0c5a0de@roeck-us.net>
References: <20261015062556.3362356-1-qiwen.neosys@isrc.iscas.ac.cn>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015062556.3362356-1-qiwen.neosys@isrc.iscas.ac.cn>

On Thu, Oct 15, 2026 at 06:25:56AM +0000, Qiwen Gong wrote:
> Add MODULE_DEVICE_TABLE(pnp, scl200wdt_pnp_devices) beside the
> existing table.  
> 
> Built with CONFIG_COMPILE_TEST=y and CONFIG_PNP=y.  modinfo of
> sc1200wdt.ko shows pnp:dNSC0800* and acpi*:NSC0800:* only after this
> change. 
> 
> Found by comparing the id_table with module-alias publication.
> 
> Signed-off-by: Qiwen Gong <qiwen.neosys@isrc.iscas.ac.cn>

Applied.

Thanks,
Guenter

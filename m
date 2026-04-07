Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615D235F8D1;
	Tue,  7 Apr 2026 21:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775596161; cv=none; b=KrCE8sl+bjgfCwT62pzHPk24SDJgbQXr2AJcea71FCeDNvbETTcWi3K/n7QOIaQ5fr/UUyTjOavqXnya5fbnIJkxHp8xkVzFtzc9P7vd1b+grxTaafUlRR6XerQpH0gB86ZxNgrP969rReIXb/3Bo42bfCWZHanz61/fuBYn3po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775596161; c=relaxed/simple;
	bh=YhpqzCqBZUVWtSJ5eI8G6bogT1yGydKk19Hoxg/n0hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsZxZRzlx6M66WDACrZ/JpD53jwD+JjEDa3mM7tYmR2aIul2eUww4piXeg/haUiOhag4/AR5Z0aIoyaRHgD/MzfD5RdidgA3ceS2wcx3TzpjMjhkJoYtEsgGWOIgBIWXQfHXWgNBmmUYkBM6NYw2E4AHiWhYQdYz7h3bcdhOuoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Bmaw9CwY; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Bmaw9CwY"
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637L3BV91394737;
	Tue, 7 Apr 2026 21:08:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pps0720; bh=7frngrok7BUpTXtSUtNZaYh2IJ
	anfs2Q739desd9MQo=; b=Bmaw9CwYZpUwVI5qX7f1arQSsbtDceJAEeTprnot+4
	hS60wiaXtrKmtKSvC3Xrk/2FLV+mpp/QDfCvT+87qVO8A58S2NKdWowHPlO946A0
	/YhoKeTeq5S0O88gbgXObnwLQmvTKwP+7pBO/oAzK6/MVxjZn/5cFqyliBNsP0BT
	tpjqK7N5vqbv5XrVERgLPa6e70Uf3uEQsLhJi7JQVP6OSC4YdGk2934hNORQhEN7
	k80CQpxXYg/nOjN8CWsoRCKJFAOZ+mSPPLfU3AmpEkXCmFfvJnIMN7Ip4waodxQL
	FDFFfWYRVrBOVsCguWfoKE51ybEGUXxYIUyp5F5QVlxA==
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 4dd8eb8ud5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 21:08:56 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id BE51080171F;
	Tue,  7 Apr 2026 21:08:55 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 66643806B6B;
	Tue,  7 Apr 2026 21:08:54 +0000 (UTC)
Date: Tue, 7 Apr 2026 16:08:52 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: kernel test robot <lkp@intel.com>
Cc: Steve Wahl <steve.wahl@hpe.com>, Craig Lamparter <craig.lamparter@hpe.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>, Keng-Yu Lin <keng-yu.lin@hpe.com>,
        Collins@owl.eag.rdlabs.hpecorp.net
Subject: Re: [PATCH] Refine hpwdt message for UV platform
Message-ID: <adVyZKrn9FNsa_7j@swahl-home.5wahls.com>
References: <20260316214530.104344-1-steve.wahl@hpe.com>
 <202604080401.igdhwsPk-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202604080401.igdhwsPk-lkp@intel.com>
X-Proofpoint-GUID: cLg0Xr-Ag8Q-qoFR_nmB-U8sInUWIYjy
X-Authority-Analysis: v=2.4 cv=Ev/iaycA c=1 sm=1 tr=0 ts=69d57268 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gQcMVamqm3wCPoSYhaRC:22 a=J0OTuHAx6l5K1fCpvPfz:22 a=anyJmfQTAAAA:8
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=MvuuwTCpAAAA:8 a=i3X5FwGiAAAA:8
 a=QyXUC8HyAAAA:8 a=f9XFED1v-RmrqyPmo0cA:9 a=CjuIK1q_8ugA:10
 a=mmqRlSCDY2ywfjPLJ4af:22
X-Proofpoint-ORIG-GUID: cLg0Xr-Ag8Q-qoFR_nmB-U8sInUWIYjy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE5MiBTYWx0ZWRfX/aL12GHrMBEl
 AfhWGvjup73vTGTsj2hsgl7FZF27NwwzceKcnlOV9CV3WwAyG6h4QFEG9FoiVzpXDm0XW840xmO
 jiSkUXA4IaoVqxF0SnsabcdqA4sk5UUjJP1L4v1csX9ZTIvJpUTXB+oqrzz1sLDpfCyXitK0iXn
 53oNuZ3pSj02yZp56M9k3sheLQ296FC7Ia1suAS93D0DF2jyS4tLtkde2nOFjr//gzl+rCm02jb
 PB0/pL4j4z48zqKpTEQk9q3viPWu3dAZcG2ANcH25Jn9xFtpqimjyKN9f/0WTIwhE7VV8hRxW8W
 EMdCZOFbGON2/oBmG35hAS+h2U1tCubRLu0tgUMUWu+damhECbJI4FESC4pBLP7H9r8abxw9jhn
 Ulnxe6DTaR7DJHf4g6gJWSRZorlyTJ1H9JMDo1f2uuJO5ZFi3fHaf7yJKs//vw88S85naz7b1R3
 X3tIGmKztBz8uagGJdg==
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_04,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 clxscore=1011
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070192

On Wed, Apr 08, 2026 at 04:33:21AM +0800, kernel test robot wrote:
> Hi Steve,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v7.0-rc7 next-20260406]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://urldefense.com/v3/__https://git-scm.com/docs/git-format-patch*_base_tree_information__;Iw!!NpxR!k-fK0rnKrk8dIBbd23JT2Hng0qw5x1aXoW9xWZWDhdr7WZTO3hcYuKVmRkiMZZQjglHR8XZE$ ]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Steve-Wahl/Refine-hpwdt-message-for-UV-platform/20260317-060404 
> base:   linus/master
> patch link:    https://lore.kernel.org/r/20260316214530.104344-1-steve.wahl%40hpe.com 
> patch subject: [PATCH] Refine hpwdt message for UV platform
> config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20260408/202604080401.igdhwsPk-lkp@intel.com/config )
> compiler: alpha-linux-gcc (GCC) 15.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260408/202604080401.igdhwsPk-lkp@intel.com/reproduce )
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202604080401.igdhwsPk-lkp@intel.com/ 
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/watchdog/hpwdt.c:28:10: fatal error: asm/uv/uv.h: No such file or directory
>       28 | #include <asm/uv/uv.h>
>          |          ^~~~~~~~~~~~~
>    compilation terminated.

I wanted to note to all on this list that the robot tested v1 of the
patch.  v2 moved this include a couple of lines up, inside the #ifdef
CONFIG_HPWDT_NMI_DECODING section and should have eliminated this
issue.

The remaning lines touched by the patch are also within an #ifdef
CONFIG_HPWDT_NMI_DECODING section.

Thanks,

--> Steve Wahl

> 
> vim +28 drivers/watchdog/hpwdt.c
> 
>     13	
>     14	#include <linux/device.h>
>     15	#include <linux/hex.h>
>     16	#include <linux/io.h>
>     17	#include <linux/kernel.h>
>     18	#include <linux/module.h>
>     19	#include <linux/moduleparam.h>
>     20	#include <linux/pci.h>
>     21	#include <linux/pci_ids.h>
>     22	#include <linux/types.h>
>     23	#include <linux/watchdog.h>
>     24	#ifdef CONFIG_HPWDT_NMI_DECODING
>     25	#include <asm/nmi.h>
>     26	#endif
>     27	#include <linux/crash_dump.h>
>   > 28	#include <asm/uv/uv.h>
>     29	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki 

-- 
Steve Wahl, Hewlett Packard Enterprise

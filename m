Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:53183 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751858AbdJJG2P (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 10 Oct 2017 02:28:15 -0400
Date: Mon, 9 Oct 2017 23:27:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: sathyanarayanan kuppuswamy
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        "Chakravarty, Souvik K" <souvik.k.chakravarty@intel.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "x86@kernel.org" <x86@kernel.org>, "wim@iguana.be" <wim@iguana.be>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "alexandre.belloni@free-electrons.com"
        <alexandre.belloni@free-electrons.com>,
        "Zha, Qipeng" <qipeng.zha@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "andy@infradead.org" <andy@infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org"
        <platform-driver-x86@vger.kernel.org>,
        "sathyaosid@gmail.com" <sathyaosid@gmail.com>
Subject: Re: [RFC v5 4/8] platform: x86: Add generic Intel IPC driver
Message-ID: <20171010062745.GA31945@infradead.org>
References: <cover.1507414288.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <983bc2330acc5eb3f384e9aed7ceba22b5c7ea5f.1507414288.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <5F7315E704FA0841B5DFCE90329B2BB4661E20EC@BGSMSX102.gar.corp.intel.com>
 <20171009071104.GA17088@infradead.org>
 <0f54e44a-5ba0-ed0f-7efe-eff05e8b79d8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f54e44a-5ba0-ed0f-7efe-eff05e8b79d8@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Oct 09, 2017 at 05:27:21PM -0700, sathyanarayanan kuppuswamy wrote:
> Hi,
> 
> 
> On 10/09/2017 12:11 AM, Christoph Hellwig wrote:
> > What does IPC stand for in this device?
> Inter processor communication

Id would suggest to explain that, as it's not how we usually use the
term in Linux?

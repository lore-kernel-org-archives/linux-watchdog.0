Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:14989 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752893AbdKWNfy (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 23 Nov 2017 08:35:54 -0500
Date: Thu, 23 Nov 2017 15:29:16 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: sathyanarayanan.kuppuswamy@linux.intel.com
Cc: a.zummo@towertech.it, x86@kernel.org, wim@iguana.be,
        mingo@redhat.com, alexandre.belloni@free-electrons.com,
        qipeng.zha@intel.com, hpa@zytor.com, dvhart@infradead.org,
        tglx@linutronix.de, lee.jones@linaro.org, andy@infradead.org,
        souvik.k.chakravarty@intel.com, linux-rtc@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, sathyaosid@gmail.com
Subject: Re: [RFC v8 4/7] platform: x86: Add generic Intel IPC driver
Message-ID: <20171123132916.GE17418@kuha.fi.intel.com>
References: <cover.1509268570.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <5c66498c110e52343d810db9c281fe72d0d299cc.1509268570.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c66498c110e52343d810db9c281fe72d0d299cc.1509268570.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On Sun, Oct 29, 2017 at 02:49:57AM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> +/**
> + * devm_intel_ipc_dev_create() - Create IPC device
> + * @dev		: IPC parent device.
> + * @devname	: Name of the IPC device.
> + * @cfg		: IPC device configuration.
> + * @ops		: IPC device ops.
> + *
> + * Resource managed API to create IPC device with
> + * given configuration.
> + *
> + * Return	: IPC device pointer or ERR_PTR(error code).
> + */
> +struct intel_ipc_dev *devm_intel_ipc_dev_create(struct device *dev,
> +		const char *devname,
> +		struct intel_ipc_dev_cfg *cfg,
> +		struct intel_ipc_dev_ops *ops)
> +{
> +	struct intel_ipc_dev **ptr, *ipc_dev;
> +	int ret;
> +
> +	if (!dev && !devname && !cfg)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (intel_ipc_dev_get(devname)) {
> +		dev_err(dev, "IPC device %s already exist\n", devname);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	ptr = devres_alloc(devm_intel_ipc_dev_release, sizeof(*ptr),
> +			GFP_KERNEL);
> +	if (!ptr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ipc_dev = kzalloc(sizeof(*ipc_dev), GFP_KERNEL);
> +	if (!ipc_dev) {
> +		ret = -ENOMEM;
> +		goto err_dev_create;
> +	}
> +
> +	ipc_dev->dev.class = &intel_ipc_class;
> +	ipc_dev->dev.parent = dev;
> +	ipc_dev->dev.groups = ipc_dev_groups;
> +	ipc_dev->cfg = cfg;
> +	ipc_dev->ops = ops;
> +
> +	mutex_init(&ipc_dev->lock);
> +	init_completion(&ipc_dev->cmd_complete);
> +	dev_set_drvdata(&ipc_dev->dev, ipc_dev);
> +	dev_set_name(&ipc_dev->dev, devname);
> +	device_initialize(&ipc_dev->dev);
> +
> +	ret = device_add(&ipc_dev->dev);
> +	if (ret < 0) {
> +		dev_err(&ipc_dev->dev, "%s device create failed\n",
> +				__func__);
> +		ret = -ENODEV;
> +		goto err_dev_add;
> +	}
> +
> +	if (ipc_dev->cfg->mode == IPC_DEV_MODE_IRQ) {
> +		if (devm_request_irq(&ipc_dev->dev,
> +				ipc_dev->cfg->irq,
> +				ipc_dev_irq_handler,
> +				ipc_dev->cfg->irqflags,
> +				dev_name(&ipc_dev->dev),
> +				ipc_dev)) {
> +			dev_err(&ipc_dev->dev,
> +					"Failed to request irq\n");
> +			goto err_irq_request;
> +		}
> +	}

That looks really wrong to me. This is the class driver, so why are
you handling the interrupts of the devices in it? You are clearly
making assumption that the interrupt will always be used only for
command completion, but that may not be the case. No assumptions.

Just define completion callbacks, and let the drivers handle the
actual interrupts.

> +	*ptr = ipc_dev;
> +
> +	devres_add(dev, ptr);
> +	return ipc_dev;
> +
> +err_irq_request:
> +	device_del(&ipc_dev->dev);
> +err_dev_add:
> +	kfree(ipc_dev);
> +err_dev_create:
> +	devres_free(ptr);
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(devm_intel_ipc_dev_create);
> +
> +static int __init intel_ipc_init(void)
> +{
> +	ipc_channel_lock_init();
> +	return class_register(&intel_ipc_class);
> +}
> +
> +static void __exit intel_ipc_exit(void)
> +{
> +	class_unregister(&intel_ipc_class);
> +}
> +subsys_initcall(intel_ipc_init);
> +module_exit(intel_ipc_exit);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Kuppuswamy Sathyanarayanan<sathyanarayanan.kuppuswamy@linux.intel.com>");
> +MODULE_DESCRIPTION("Intel IPC device class driver");

To be honest, creating an extra logical device for the IPC hosts, and
the entire class, all feel unnecessarily complex to me.

The goal of this patch should be possible to achieve in a much simpler
and flexible way. IMO this patch needs to be redesigned.


Thanks,

-- 
heikki
